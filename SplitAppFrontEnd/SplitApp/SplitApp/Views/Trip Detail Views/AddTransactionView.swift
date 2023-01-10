//
//  AddTransactionView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct AddTransactionView:View{
    let trip:Trip
    @Binding var popupBool: Bool
    @Binding var transaction: [Transaction]
    @EnvironmentObject var envVar: EnviormentVariables
    @State var cost: Double = 0.00
    @State var date: Date = Date.now
    
    @State var description: String = ""
    
    let formatter = NumberFormatter()
    

    var body: some View{
        VStack{
            HStack {
                Text("$").font(.largeTitle).bold().padding()
                TextField("Cost", value: $cost, formatter: formatter).font(.largeTitle).bold().padding()
                Button(action: {
                    cost = 0
                }, label: {
                    Image(systemName: "multiply.circle.fill").foregroundColor(.secondary).padding()
                })
            }.frame(width: 350).background(.quaternary).cornerRadius(10).padding()
            
            DatePicker("", selection: $date, displayedComponents: .date).datePickerStyle(.compact)
            Text("Description")
            TextEditor(text: $description).frame(width: 325, height: 200).padding().scrollContentBackground(.hidden).background(.quaternary).cornerRadius(10)
            Button(action: {
                Task{
                    if description.isEmpty{
                        _ = try await envVar.createTransaction(transaction:Transaction(id: "",userId: envVar.username, tripId: trip._id, cost: cost, date: envVar.dateToStr(date: date), votesToDelete: []))
                    }else{
                        _ = try await envVar.createTransaction(transaction:Transaction(id: "",userId: envVar.username, tripId: trip._id, cost: cost, date: envVar.dateToStr(date: date), votesToDelete: [], description: description))
                    }
                    self.transaction = try await envVar.getTransactionsFortrip(trip: self.trip)
                }
                popupBool = false
                
            }, label: {
                Text("Add Transaction").padding().frame(width: 350).background(.tint).foregroundColor(.white).bold()
            }).cornerRadius(10)
            
        }.onAppear(perform: {
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
        })
    }
}
