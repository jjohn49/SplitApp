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
                OverallCostView(totalCost: totalCost, howMuchYouHaveSpent: howMuchYouHaveSpent, transactions: transactions, chartData: chartData, trip: trip)
                //Text("Transactions").font(.title).bold()
                List{
                    ForEach(transactions.reversed()) { transaction in
                        TransactionRow(transaction: transaction)
                    }.onDelete(perform: deleteTransactionRow)
                }.frame(height: 400)
                
                
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
        })
    }
    
    func getVariablesOnAppear() async throws{
        do{
            try await getVariablesForTripdetailView()
        }catch let error{
            print(error)
        }
    }
    
    func deleteTransactionRow(at offsets: IndexSet){
        let theTransaction = transactions.reversed()[offsets.first!]
        Task{
            let res = try await envVar.deleteTransaction(transaction:theTransaction)
            if(res){
                try await getVariablesForTripdetailView()
            }
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



