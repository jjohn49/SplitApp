//
//  EnviormentVariables.swift
//  SplitApp
//
//  Created by John Johnston on 10/15/22.
//

import Foundation

struct Users: Codable{
    let _id:String
    let password : String
    let fName:String
    let lName: String
    let email: String
    
    enum CodingKeys: String, CodingKey{
        case _id
        case password
        case fName
        case lName
        case email
    }
}

struct Transaction: Codable, Identifiable{
    let id: String
    let userId: String
    let tripId: String
    var cost: Double
    let date: String
    
    // case *name in struct* = *name in the json*
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId = "userId"
        case tripId = "tripId"
        case cost = "cost"
        case date = "date"
    }
    
}

struct Trip: Identifiable, Codable{
    var id = UUID()
    let _id : String
    var name: String
    var users: [String]
    var startDate: String
    var endDate: String
    
    enum CodingKeys: String, CodingKey{
        case _id = "_id"
        case name = "name"
        case users = "users"
        case startDate = "startDate"
        case endDate = "endDate"
    }
}

//Enviorment Object that contains all the methods I want to carry over and use in multiple views
//Possibly rename this and or split it up into different classes for readability
class EnviormentVariables: ObservableObject{
    @Published var username: String = "mmoran"
    //Use this for password verification
    //@Published var jsToken = null
    @Published var fName: String = ""
    @Published var lName: String = ""
    @Published var email: String = ""
    //this is for when I am working on account authorization
    //Think about maybe using JSON Web Token instead
    @Published var isSignedIn: Bool = false
    @Published var trips: [Trip] = []
    
    //Maybe add an array of the transactions
    
    
    //Method that gets how much you have spent in a list of transactions
    //Usually used in the TripDetailViews
    func getHowMuchYouveSpent(transactions:[Transaction]) ->Double{
        var cost: Double = 0.00
        transactions.forEach({x in
            if x.userId == self.username{
                cost += x.cost
            }
        })
        return cost
    }
    
    func getCostDataForChart(transactions:[Transaction]) async throws -> [Transaction]{
        var chartData: [Transaction] = []
        
        var costDictionary: [String: Double] = ["Group": 0]
        
        if(!transactions.isEmpty){
            
            for x in 0..<transactions.count{
                
                var currentTransaction = transactions[x]
                
                if !costDictionary.keys.contains(currentTransaction.userId){
                    costDictionary[currentTransaction.userId] = 0
                }
                
                costDictionary[currentTransaction.userId]! += currentTransaction.cost
                costDictionary["Group"]! += currentTransaction.cost
                
                currentTransaction.cost = costDictionary[currentTransaction.userId]!
                
                chartData.append(currentTransaction)
                
                chartData.append(Transaction(id: UUID().description, userId: "Group" , tripId: currentTransaction.tripId, cost: costDictionary["Group"]!, date: currentTransaction.date))
                
            }
            
            return sortTransactions(transactions: chartData)
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
        return transactions.sorted(by: {strToDate(strDate: $0.date).compare(strToDate(strDate: $1.date)) == .orderedAscending})
    }
    
    //this works just need to wait for user
    func getAllTripsForUser(){
        let userId = self.username
        
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
        urlRequest.httpBody = jsonBody
        
        let task = URLSession.shared.dataTask(with: urlRequest){
            data, response, error in
            
            
            if let error = error{
                print("Request error: ", error)
                return
            }
        
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard let data = data else{
                return
            }
            
            DispatchQueue.main.async {
                do{
                    let decodedTrips = try JSONDecoder().decode([Trip].self, from: data)
                    self.trips = decodedTrips
                    //print(self.trips)
                }catch let error{
                    print(error)
                }
            }
            
        }

        task.resume()
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
            let (data, _) = try await URLSession.shared.upload(for: urlRequest, from: jsonTransaction)
            
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
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        //print(data)
        
        return true
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
            let (data, _) = try await URLSession.shared.upload(for: urlRequest, from: jsonTransaction)
            
            /*if let resp = String(data: data, encoding: .utf8){
                print(resp)
            }*/
        }catch{
            print("Error sending")
            return false
        }
        
        return true
    }
    
}
