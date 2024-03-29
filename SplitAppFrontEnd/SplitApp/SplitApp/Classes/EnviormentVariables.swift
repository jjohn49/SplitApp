//
//  EnviormentVariables.swift
//  SplitApp
//
//  Created by John Johnston on 10/15/22.
//

import Foundation

//Enviorment Object that contains all the methods I want to carry over and use in multiple views
//Possibly rename this and or split it up into different classes for readability
@MainActor
class EnviormentVariables: ObservableObject{
    
    @Published var currentUser: Users = Users(_id: "jjohns49", password: "password", fName: "Jack", lName: "Johnston", email: "test@test.com")
    
    /*
    @Published var username: String = "jjohns49"
    //Use this for password verification
    //@Published var jsToken = null
    @Published var fName: String = ""
    @Published var lName: String = ""
    @Published var email: String = ""*/
    //this is for when I am working on account authorization
    //Think about maybe using JSON Web Token instead
    @Published var isSignedIn: Bool = false
    @Published var trips: [Trip] = []
    @Published var oldTrips: [Trip] = []
    
    @Published var currentTrip: Trip?
    
    @Published var allTransactions: [Transaction] = []
    
    //Maybe add an array of the transactions
    
    func refreshEnvVars() async throws{
        try await getAllTripsForUser()
        try await getAllTransactionsForTripsWithUser()

    }
    
    
    
    
    //Method that gets how much you have spent in a list of transactions
    //Usually used in the TripDetailViews
    func getHowMuchYouveSpent(transactions:[Transaction]) ->Double{
        var cost: Double = 0.00
        transactions.forEach({x in
            if x.userId == self.currentUser._id{
                cost += x.cost
            }
        })
        return cost
    }
    
    func getCostDataForChart(transactions:[Transaction]) async throws -> [Transaction]{
        var chartData: [Transaction] = []
        
        let reversedTransactions = transactions.reversed() as [Transaction]
        
        var costDictionary: [String: Double] = ["Group": 0]
        
        if(!reversedTransactions.isEmpty){
            
            for x in 0..<reversedTransactions.count{
                
                var currentTransaction = reversedTransactions[x]
                
                if !costDictionary.keys.contains(currentTransaction.userId){
                    costDictionary[currentTransaction.userId] = 0
                }
                
                costDictionary[currentTransaction.userId]! += currentTransaction.cost
                costDictionary["Group"]! += currentTransaction.cost
                
                currentTransaction.cost = costDictionary[currentTransaction.userId]!
                
                chartData.append(currentTransaction)
                
                chartData.append(Transaction(id: UUID().description, name: currentTransaction.name , userId: "Group" , tripId: currentTransaction.tripId, cost: costDictionary["Group"]!, date: currentTransaction.date, votesToDelete: [], category: currentTransaction.category))
                
            }
            
            //print(chartData)
            return chartData
        }
        
        return []
    }
    
    
    func strToDate(strDate: String) -> Date{
        let format = DateFormatter()
        format.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'000Z"
        return format.date(from: strDate)!
    }
    
    func dateToStr(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        return format.string(from: date)
    }
    
    func dateToStrToDate(date: Date)-> Date{
        let d = dateToStr(date: date)
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        return format.date(from: d)!
    }
    
    func strToDateToStr(strDate: String) -> String {
        let date = strToDate(strDate: strDate)
        return dateToStr(date: date)
    }
    
    func sortTransactions(transactions: [Transaction]) -> [Transaction]{
        return transactions.sorted(by: {strToDate(strDate: $0.date).compare(strToDate(strDate: $1.date)) == .orderedDescending})
    }
    
    func sortTrips(trips: [Trip]) -> [Trip]{
        return trips.sorted(by: {strToDate(strDate: $0.endDate).compare(strToDate(strDate: $1.endDate)) == .orderedDescending})
    }
    
    //this works just need to wait for user
    func getAllTripsForUser() async throws{
        let userId = self.currentUser._id
        
        guard let url = URL(string: "http:localhost:3000/trips-for-user") else{
            return
        }
        
        let body = [
            "userId" : userId
        ]
        
        //converts body to json to send in req body
        guard let jsonBody = try? JSONEncoder().encode(body) else{
            print("Failed to encode")
            return
        }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: urlRequest, from: jsonBody)
            let decodedTrips = try JSONDecoder().decode([Trip].self, from: data)
            
            //Makes sure the variable is update on main branch
            //Thriows annoying warning if not
            await MainActor.run{
                self.trips = self.sortTrips(trips: decodedTrips)
            }
            
            
            //print(self.trips)
        }catch let error{
            print(error)
        }
        
    }
    
    func getAllTransactionsForTripsWithUser() async throws{
        guard let url = URL(string: "http:localhost:3000/transactions-for-trips-with-user") else{
            return
        }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let usernamePreJson = [
            "userId" : currentUser._id
        ]
        
        let jsonUsername = try JSONEncoder().encode(usernamePreJson)
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: urlRequest, from: jsonUsername)
            
            let decodedTransactions = try JSONDecoder().decode([Transaction].self, from: data)
            //print(sortTransactions(transactions: decodedTransactions))
            await MainActor.run{
                self.allTransactions = sortTransactions(transactions: decodedTransactions)
            }
            
        }catch {
            print(error)
            return
        }
        
    }
    
    //works
    func getTransactionsFortrip(trip:Trip) async throws -> [Transaction]{
        
        guard let url = URL(string: "http:localhost:3000/transactions-for-trip?trip=\(trip._id)") else{
            return []
        }
        
        //converts body to json to send in req body
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        //urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decodedTransactions = try JSONDecoder().decode([Transaction].self, from: data)
        
        return sortTransactions(transactions: decodedTransactions)
        
        //add the api call for the endpoint that corresponsds with getTransactionsForTrip
    }
    
    
    //works
    func createTransaction(transaction:Transaction) async throws -> Bool{
        guard let url = URL(string: "http:localhost:3000/new-transaction") else{
            return false
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let jsonTransaction = try JSONEncoder().encode(transaction)
        
        do{
            let (_, _) = try await URLSession.shared.upload(for: urlRequest, from: jsonTransaction)
            
            /*if let resp = String(data: data, encoding: .utf8){
                print(resp)
            }*/
        }catch{
            print("Error sending")
            return false
        }
        
        return true
    }
    
    func deleteTransaction(transaction: Transaction) async throws -> Bool{
        
        guard let url = URL(string: "http:localhost:3000/delete-transaction?transaction=\(transaction.id)") else{
            return false
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "DELETE"
        
        let (_, _) = try await URLSession.shared.data(for: urlRequest)
        //print(data)
        
        return true
    }
    
    func updateTransaction(transaction: Transaction) async throws {
        print("Tried to update")
        guard let url = URL(string: "http:localhost:3000/update-transaction?transaction=\(transaction.id)") else{
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "PUT"
        
        let jsonTransaction = try JSONEncoder().encode(transaction)
        
        do{
            let (_, _) = try await URLSession.shared.upload(for: urlRequest, from: jsonTransaction)
            
            /*if let resp = String(data: data, encoding: .utf8){
                print(resp)
            }*/
        }catch{
            print("Error sending")
            return
        }
    }
    
    func updateVotesToDelete(transaction: Transaction) async throws{
        //print(transaction.votesToDelete.count >= trips.first(where: {$0._id == transaction.tripId})?.users.count ?? 0)
        if transaction.votesToDelete.count >= trips.first(where: {$0._id == transaction.tripId})?.users.count ?? 0{
            _ = try await deleteTransaction(transaction: transaction)
        }else{
            try await updateTransaction(transaction: transaction)
        }
    }
    
    func createTrip(trip:Trip) async throws -> Bool{
        guard let url = URL(string: "http:localhost:3000/new-trip") else{
            return false
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let jsonTransaction = try JSONEncoder().encode(trip)
        
        do{
            let (_, _) = try await URLSession.shared.upload(for: urlRequest, from: jsonTransaction)
            
            /*if let resp = String(data: data, encoding: .utf8){
                print(resp)
            }*/
        }catch{
            print("Error sending")
            return false
        }
        
        return true
    }
    
    func updateVotesToDeleteTrip(trip: Trip) async throws -> Bool{
        
        if trip.votesToEndTrip.count == trip.users.count{
            _ = try await deleteTrip(trip: trip)
        }else{
            print("updating \(trip.name)")
            guard let url = URL(string: "http:localhost:3000/update-trip-vtd?trip=\(trip._id)") else{
                return false
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "PUT"
            
            let (_, _) = try await URLSession.shared.data(for: urlRequest)
        }
        
        return true
    }
    
    func deleteTrip(trip: Trip) async throws -> Bool{
        
        guard let url = URL(string: "http:localhost:3000/delete-trip?trip=\(trip._id)") else{
            return false
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "DELETE"
        
        let (_, _) = try await URLSession.shared.data(for: urlRequest)
        
        return true
    }
    
    
}
