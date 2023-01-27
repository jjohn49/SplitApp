//
//  Transaction.swift
//  SplitApp
//
//  Created by John Johnston on 1/26/23.
//

import Foundation

struct Transaction: Codable, Identifiable{
    let id: String
    let userId: String
    let tripId: String
    var cost: Double
    let date: String
    var votesToDelete: [String]
    var description: String?
    
    // case *name in struct* = *name in the json*
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId = "userId"
        case tripId = "tripId"
        case cost = "cost"
        case date = "date"
        case votesToDelete = "votesToDelete"
        case description = "description"
    }
    
}
