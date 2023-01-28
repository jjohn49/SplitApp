//
//  Trip.swift
//  SplitApp
//
//  Created by John Johnston on 1/26/23.
//

import Foundation

struct Trip: Identifiable, Codable{
    var id = UUID()
    let _id : String
    var name: String
    var users: [String]
    var startDate: String
    var endDate: String
    var categories: [String] = ["Food","Clothes","Activities","Other"]
    var votesToEndTrip: [String]
    
    enum CodingKeys: String, CodingKey{
        case _id = "_id"
        case name = "name"
        case users = "users"
        case startDate = "startDate"
        case endDate = "endDate"
        case categories = "transactionCategories"
        case votesToEndTrip = "votesToEndTrip"
    }
}
