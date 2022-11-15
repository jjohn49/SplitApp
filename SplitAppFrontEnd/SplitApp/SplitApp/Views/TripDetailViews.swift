//
//  TripDetailViews.swift
//  SplitApp
//
//  Created by John Johnston on 11/5/22.
//

import SwiftUI
import Charts

struct TripDetalView:View{
    @EnvironmentObject var envVar: EnviormentVariables
    @State var popupBool: Bool = false
    let trip: Trip
    @State var totalCost: Double = 0.00
    @State var transactions: [Transaction] = []
    @State var chartData: [(String,Double)] = []
    @State var howMuchYouHaveSpent: Double = 0.00
    var body: some View{
        VStack {
            ScrollView{
                ZStack(alignment: .topLeading){
                    MoneySpentView(totalCost: totalCost, howMuchYouHaveSpent: howMuchYouHaveSpent, trip: trip).padding()
                    ChartView(transactions: transactions, chartData: chartData).frame(width: 400,height: 200)
                }
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
                do{
                    try await getVariablesForTripdetailView()
                }catch let error{
                    print(error)
                }
            }
        }).popover(isPresented: $popupBool, content: {
            AddTransactionView(trip: trip, popupBool: $popupBool, transaction: $transactions).onDisappear(perform:{
                Task{
                    try await getVariablesForTripdetailView()
                }
            })
        })
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
            let (_, cost) = chartData[chartData.count-1]
            self.totalCost = cost
            self.howMuchYouHaveSpent = envVar.getHowMuchYouveSpent(transactions: self.transactions)
        }
    }
}



struct MoneySpentView:View{
    let totalCost: Double
    let howMuchYouHaveSpent: Double
    let trip: Trip
    var body: some View{
        VStack{
            Text("$\(String(totalCost))").font(.title).bold()
            HStack{
                let avgCost = totalCost / Double(trip.users.count)
                if(avgCost <= howMuchYouHaveSpent){
                    Text("$\(String(format: "%.2f", howMuchYouHaveSpent-avgCost))").foregroundColor(.green).font(.title3).bold()
                }else{
                    Text("$\(String(format: "%.2f", avgCost - howMuchYouHaveSpent))").foregroundColor(.red).font(.title3).bold()
                }
                Text("$\(String(howMuchYouHaveSpent))").font(.caption).bold()
            }
        }
    }
}

struct AddTransactionView:View{
    let trip:Trip
    @Binding var popupBool: Bool
    @Binding var transaction: [Transaction]
    @EnvironmentObject var envVar: EnviormentVariables
    @State var cost: String = "0.00"
    @State var date: Date = Date.now
    var body: some View{
        VStack{
            TextField("Cost", text: $cost).keyboardType(.numberPad)
            DatePicker("Date", selection: $date)
            Button(action: {
                Task{
                    try await envVar.createTransaction(transaction:Transaction(id: "",userId: envVar.username, tripId: trip._id, cost: Double(cost) ?? 0.00, date: "11-08-2022"))
                    self.transaction = try await envVar.getTransactionsFortrip(trip: self.trip)
                }
                popupBool = false
                
            }, label: {
                Text("Submit")
            })
        }
    }
}

struct TransactionRow:View{
    @EnvironmentObject var envVar: EnviormentVariables
    let transaction: Transaction
    
    var body: some View{
        HStack {
            VStack{
                Text("$\(transaction.cost, specifier: "%.2f")").foregroundColor(.black).font(.title2).bold()
                Text("\(transaction.userId)")
                
            }
            Spacer()
            Text(envVar.strToDateToStr(strDate: transaction.date))
        }
    }
    
    
}


//https://www.appcoda.com/swiftui-line-charts/
struct ChartView:View{
    @EnvironmentObject var envVar: EnviormentVariables
    let transactions: [Transaction]
    let chartData: [(String,Double)]
    @State var cost: [Int] = [0]
    var body: some View{
        ZStack {
            Chart{
                ForEach(0..<chartData.count, id: \.self){ x in
                    let (date, tempC) = chartData[x]
                    LineMark(x: .value("Date", envVar.strToDateToStr(strDate: date)), y: .value("Cost", Int(tempC)))
                }.symbol(.circle)
                
            }.frame(width: 375, height: 200)
        }
    }
    
}

