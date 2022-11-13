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
    //@State var chartDataForYou: [(String, Double)] = []
    var body: some View{
        VStack {
            ScrollView{
                ChartView(transactions: transactions, chartData: chartData).frame(width: 400,height: 200)
                //Text("Transactions").font(.title).bold()
                HStack{
                    Text("$"+String(totalCost))
                }
                List{
                    ForEach(transactions.reversed()) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                    
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
                    self.transactions = try await envVar.getTransactionsFortrip(trip: trip)
                    self.chartData = try await envVar.getCostDataForChart(transactions: self.transactions)
                    let (_, cost) = chartData[chartData.count-1]
                    self.totalCost = cost
                    //self.chartDataForYou = try await envVar.getCostdatafroChartForYou(transactions: self.transactions)
                }catch let error{
                    print(error)
                }
            }
        }).popover(isPresented: $popupBool, content: {
            AddTransactionView(trip: trip, popupBool: $popupBool, transaction: $transactions)
        })
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
                    try await envVar.makeTransactionForAtrip(transaction:Transaction(userId: envVar.username, tripId: trip._id, cost: Double(cost) ?? 0.00, date: "11-08-2022"))
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
    //let yourChartData: [(String,Double)]
    @State var cost: [Int] = [0]
    var body: some View{
        ZStack {
            Chart{
                ForEach(0..<chartData.count, id: \.self){ x in
                    let (date, tempC) = chartData[x]
                    LineMark(x: .value("Date", envVar.strToDateToStr(strDate: date)), y: .value("Cost", Int(tempC)))
                }
                
            }.frame(width: 375, height: 200)
        }
    }
    
}

