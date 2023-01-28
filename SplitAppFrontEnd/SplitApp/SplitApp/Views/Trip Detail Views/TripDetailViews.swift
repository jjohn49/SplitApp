//
//  TripDetailViews.swift
//  SplitApp
//
//  Created by John Johnston on 11/5/22.
//

import SwiftUI

struct TripDetalView:View{
    @EnvironmentObject var envVar: EnviormentVariables
    @State var addTransactionPopup: Bool = false
    @State var endTripAlert: Bool = false
    @State var trip: Trip
    @State var totalCost: Double = 0.00
    @State var transactions: [Transaction] = []
    @State var chartData: [Transaction] = []
    @State var howMuchYouHaveSpent: Double = 0.00
    
    
    var body: some View{
        VStack {
            
            TripDetailBody(totalCost: $totalCost, howMuchYouHaveSpent: $howMuchYouHaveSpent, transactions: $transactions, chartData: $chartData, trip: $trip)
            
            
        }.navigationTitle(trip.name)
        .onAppear(perform: {
            envVar.currentTrip = trip
            Task{
                try await getVariablesOnAppear()
            }
        }).popover(isPresented: $addTransactionPopup, content: {
            AddTransactionView(trip: trip, popupBool: $addTransactionPopup, transaction: $transactions).onDisappear(perform:{
                Task{
                    try await getVariablesForTripdetailView()
                }
            })
        }).toolbar(content: {
            Menu(content: {
                Button("Add Transaction", action: {
                    addTransactionPopup = true
                })
            }, label: {
                Image(systemName: "plus")
            })
        })
    }
    
    func getVariablesOnAppear() async throws{
        do{
            try await getVariablesForTripdetailView()
        }catch let error{
            print(error)
        }
    }
    
    func getVariablesForTripdetailView() async throws{
        self.transactions = try await envVar.getTransactionsFortrip(trip: trip)
        self.chartData = try await envVar.getCostDataForChart(transactions: self.transactions)
        if(!chartData.isEmpty){
            self.totalCost = chartData[chartData.count-1].cost
            self.howMuchYouHaveSpent = envVar.getHowMuchYouveSpent(transactions: self.transactions)
        }
    }
}





