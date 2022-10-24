//
//  EnviormentVariables.swift
//  SplitApp
//
//  Created by John Johnston on 10/15/22.
//

import Foundation

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
    @Published var username: String = ""
    @Published var fName: String = ""
    @Published var lName: String = ""
    @Published var email: String = ""
    @Published var isSignedIn: Bool = false
    @Published var trips: [Trip] = []
    
    //This works
    func getAllTrips(){
        guard let url = URL(string: "http:localhost:3000/get-trips") else{
            return
        }
        
        let urlRequest = URLRequest(url: url)


        let task = URLSession.shared.dataTask(with: urlRequest){
            data, response, error in
            
            
            
            if let error = error{
                print("Request error: ", error)
                return
            }
            
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200{
                guard let data = data else{
                    return
                }
                
                
                
                DispatchQueue.main.async {
                    do{
                        let decodedTrips = try JSONDecoder().decode([Trip].self, from: data)
                        self.trips = decodedTrips
                    }catch let error{
                        print(error)
                    }
                }
            }
        }

        task.resume()
    }
    
    //this works just need to wait for user
    func getAllTripsForUser(userId: String){
        guard let url = URL(string: "http:localhost:3000/trips-for-user") else{
            return
        }
        
        let body = "userId = \(userId)"
        let codedBody = body.data(using: .utf8)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = codedBody
        
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
                }catch let error{
                    print(error)
                }
            }
            
        }

        task.resume()
    }
    
    
    
}
