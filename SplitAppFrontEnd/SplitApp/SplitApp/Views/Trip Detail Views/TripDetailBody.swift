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
    @Binding var isAddTransaction: Bool
    let geo: GeometryProxy
    var body: some View{
        ScrollView{
            OverallCostView(totalCost: totalCost, howMuchYouHaveSpent: howMuchYouHaveSpent, transactions: $transactions, chartData: $chartData, trip: trip).frame(width: geo.size.width - 30, height: geo.size.height - 400, alignment: .center).background(Color("m")).cornerRadius(10).padding()
            //Text("Transactions").font(.title).bold()
            Text("Transactions").font(.title2).bold().underline().frame(alignment: .leading)
            MostRecentTransactions(transactions: $transactions).padding().frame(width: geo.size.width - 30, height: geo.size.height - 450).background(Color("m")).cornerRadius(10)
            
            Button(action: {
                DispatchQueue.main.async {
                    isAddTransaction = true
                }
            }, label: {
                Text("Add Transaction").padding()
            }).frame(width: geo.size.width - 30).background(Color("purple")).foregroundColor(Color("wb")).cornerRadius(10)
            if trip.endDate != "" {
                VoteToEndTripButton(trip: $trip, geo: geo)
            }else{
                //Add vote to reopen trip
            }
            
        }.frame(width: geo.size.width, height: geo.size.height)
    }
}


