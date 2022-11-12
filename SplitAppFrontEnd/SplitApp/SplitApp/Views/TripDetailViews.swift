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
    @State var transactions: [Transaction] = []
    var body: some View{
        VStack {
            ScrollView{
                ChartView(transactions: transactions).frame(width: 400,height: 200)
                //Text("Transactions").font(.title).bold()
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
                    print(self.transactions)
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
    let transaction: Transaction
    
    var body: some View{
        HStack {
            VStack{
                Text("$\(transaction.cost, specifier: "%.2f")").foregroundColor(.black).font(.title2).bold()
                Text("\(transaction.userId)")
                
            }
            Spacer()
            Text(strToDateToStr())
        }
    }
    
    func strToDate() -> Date{
        let format = DateFormatter()
        format.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'000Z"
        return format.date(from: self.transaction.date)!
    }
    
    func strToDateToStr() -> String {
        let date = strToDate()
        let format = DateFormatter()
        format.dateFormat = "MM/dd"
        return format.string(from: date)
    }
}


//https://www.appcoda.com/swiftui-line-charts/
struct ChartView:View{
    let transactions: [Transaction]
    @State var cost: [Int] = [0]
    var body: some View{
        ZStack {
            Chart{
                ForEach(transactions) { transaction in
                    LineMark(x: .value("Date", strToDateToStr(transaction: transaction)), y: .value("Cost", transaction.cost))
                }
            }.frame(width: 375, height: 200)
        }
    }
    
    
    
    
    func strToDate(transaction: Transaction) -> Date{
        let format = DateFormatter()
        format.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'000Z"
        return format.date(from: transaction.date)!
    }
    
    func strToDateToStr(transaction: Transaction) -> String {
        let date = strToDate(transaction: transaction)
        let format = DateFormatter()
        format.dateFormat = "MM/dd"
        return format.string(from: date)
    }
    
    
}

