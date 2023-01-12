//
//  TripDetailBody.swift
//  SplitApp
//
//  Created by John Johnston on 1/12/23.
//

import SwiftUI

struct TripDetailBody: View{
    @Binding var totalCost: Double
    @Binding var howMuchYouHaveSpent: Double
    @Binding var transactions: [Transaction]
    @Binding var chartData: [Transaction]
    @Binding var trip: Trip
    var body: some View{
        ScrollView{
            OverallCostView(totalCost: totalCost, howMuchYouHaveSpent: howMuchYouHaveSpent, transactions: $transactions, chartData: $chartData, trip: trip).frame(width: 350, height: 300).background(.white).cornerRadius(10).padding()
            //Text("Transactions").font(.title).bold()
            Text("Transactions").font(.title2).bold().underline().frame(alignment: .leading)
            MostRecentTransactions(transactions: $transactions).padding().frame(width: 350, height: 200).background(.white).cornerRadius(10)
            
        }
    }
}
