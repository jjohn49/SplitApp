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
            OverallCostView(totalCost: totalCost, howMuchYouHaveSpent: howMuchYouHaveSpent, transactions: $transactions, chartData: $chartData, trip: trip).frame(width: 350, height: 300).background(Color("m")).cornerRadius(10).padding()
            //Text("Transactions").font(.title).bold()
            Text("Transactions").font(.title2).bold().underline().frame(alignment: .leading)
            MostRecentTransactions(transactions: $transactions).padding().frame(width: 350, height: 200).background(Color("m")).cornerRadius(10)
            
            if trip.endDate != "" {
                VoteToEndTripButton(trip: $trip)
            }else{
                
            }
            
        }
    }
}

struct VoteToEndTripButton: View{
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var trip: Trip
    var body: some View{
        Button(action: {
            Task{
                if !trip.votesToEndTrip.contains(envVar.username){
                    trip.votesToEndTrip.append(envVar.username)
                    _ = try await envVar.updateVotesToDeleteTrip(trip: trip)
                }
            }
        }, label: {
            Text("Vote to End the Trip").padding()
        }).frame(width: 350).background(.orange).foregroundColor(Color("wb")).cornerRadius(10)
    }
}
