//
//  EnviormentVariables.swift
//  SplitApp
//
//  Created by John Johnston on 10/15/22.
//

import Foundation

class EnviormentVariables: ObservableObject{
    @Published var username: String = ""
    @Published var fName: String = ""
    @Published var lName: String = ""
    @Published var email: String = ""
    @Published var isSignedIn: Bool = false
    @Published var trips: [Trip] = [
        Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
             Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
                  Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
        Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
        Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
        Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
             Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
                  Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
        Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now),
        Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now)
    ]
    
    //Need to change this 
    func callAPI(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else{
            return
        }


        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
            }
        }

        task.resume()
    }
    
}
