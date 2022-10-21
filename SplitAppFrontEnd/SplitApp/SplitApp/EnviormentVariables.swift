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
        Trip(id: "1", name: "Trip", users: ["me"], startDate: Date.now, endDate: Date.now)
    ]
}
