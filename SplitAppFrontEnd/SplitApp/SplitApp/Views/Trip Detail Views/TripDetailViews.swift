//
//  TripDetailViews.swift
//  SplitApp
//
//  Created by John Johnston on 11/5/22.
//

import SwiftUI

struct TripDetalView:View{
    @EnvironmentObject var envVar: EnviormentVariables
    @State var popupBool: Bool = false
    let trip: Trip
    @State var totalCost: Double = 0.00
    @State var transactions: [Transaction] = []
    @State var chartData: [Transaction] = []
    @State var howMuchYouHaveSpent: Double = 0.00
    var body: some View{
        VStack {
            ScrollView{
                OverallCostView(totalCost: totalCost, howMuchYouHaveSpent: howMuchYouHaveSpent, transactions: transactions, chartData: chartData, trip: trip).frame(width: 350, height: 300).background(.white).cornerRadius(10).padding()
                //Text("Transactions").font(.title).bold()
                
                Text("Transactions").font(.title2).bold().underline().frame(alignment: .leading)
                NavigationLink(destination: {
                    ListOfTransactions(getVariablesForTripdetailView: getVariablesForTripdetailView, transactions: $transactions).navigationTitle("Transactions")
                }, label: {
                    MostRecentTransactions(transactions: $transactions).padding()
                }).frame(width: 350, height: 200).background(.white).cornerRadius(10)
                
            }
            Button(action: {
                popupBool = true
            }, label: {
                Text("Add a Transaction").padding().frame(width: 350).background(.tint).foregroundColor(.white).bold()
            }).cornerRadius(10)
            Spacer()
            
        }.navigationTitle(trip.name)
        .onAppear(perform: {
            Task{
                try await getVariablesOnAppear()
            }
        }).popover(isPresented: $popupBool, content: {
            AddTransactionView(trip: trip, popupBool: $popupBool, transaction: $transactions).onDisappear(perform:{
                Task{
                    try await getVariablesForTripdetailView()
                }
            })
        }).background(.quaternary)
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



