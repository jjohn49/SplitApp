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

struct Transaction: Codable{
    let _id: [String:String]
    let userId: String
    let tripId: [String:String]
    let cost: Int
    
    enum CodingKeys: String, CodingKey{
        case _id
        case userId
        case tripId
        case cost
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
        case _id
        case name
        case users
        case startDate
        case endDate
    }
}


class EnviormentVariables: ObservableObject{
    @Published var username: String = "jjohns49"
    //Use this for password verification
    //@Published var jsToken = null
    @Published var fName: String = ""
    @Published var lName: String = ""
    @Published var email: String = ""
    @Published var isSignedIn: Bool = false
    @Published var trips: [Trip] = []
    
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
                    print(self.trips)
                }catch let error{
                    print(error)
                }
            }
            
        }

        task.resume()
    }
    
    func getTransactionsFortrip(){
        let trip: Trip
        
        //add the api call for the endpoint that corresponsds with getTransactionsForTrip
    }
    
}
