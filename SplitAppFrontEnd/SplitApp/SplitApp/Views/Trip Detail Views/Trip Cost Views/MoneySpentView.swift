//
//  MoneySpentView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct MoneySpentView:View{
    let totalCost: Double
    let howMuchYouHaveSpent: Double
    let trip: Trip
    var body: some View{
        VStack{
            Text("$\(String(format: "%.2f", totalCost))").font(.title).bold()
            HStack{
                let avgCost = totalCost / Double(trip.users.count)
                if(avgCost <= howMuchYouHaveSpent){
                    Text("$\(String(format: "%.2f", howMuchYouHaveSpent-avgCost))").foregroundColor(.green).font(.title3).bold()
                }else{
                    Text("$\(String(format: "%.2f", avgCost - howMuchYouHaveSpent))").foregroundColor(.red).font(.title3).bold()
                }
                Text("$\(String(format: "%.2f", howMuchYouHaveSpent))").font(.caption).bold()
            }
        }
    }
}
