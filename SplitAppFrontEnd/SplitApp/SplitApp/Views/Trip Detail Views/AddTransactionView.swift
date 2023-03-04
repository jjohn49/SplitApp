//
//  AddTransactionView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct AddTransactionView:View{
    @State var trip:Trip
    @Binding var popupBool: Bool
    @Binding var transaction: [Transaction]
    @EnvironmentObject var envVar: EnviormentVariables
    @State var name: String = ""
    @State var cost: Double = 0.00
    @State var date: Date = Date.now
    @State var category: String = ""
    @State var description: String = ""
    
    let formatter = NumberFormatter()

    var body: some View{
        VStack{
            TextField("Name", text: $name).font(.largeTitle).bold().padding().frame(width: 350).background(.quaternary).cornerRadius(10).padding()
            
            HStack {
                Text("$").font(.largeTitle).bold().padding()
                
                //Need to make this stop the rounding
                
                TextField("Cost", value: $cost, formatter: formatter).font(.largeTitle).bold().padding()
                Button(action: {
                    cost = 0.00
                }, label: {
                    Image(systemName: "multiply.circle.fill").foregroundColor(.secondary).padding()
                })
            }.frame(width: 350).background(.quaternary).cornerRadius(10).padding()
            
            Picker("Category", selection: $category){
                ForEach(trip.categories, id: \.self) { category in
                    Text(category)
                }
            }.pickerStyle(.segmented).padding()
            
            HStack {
                Text("Date of Transaction:").bold()
                DatePicker("", selection: $date, displayedComponents: .date)
            }.padding()
            
            Text("Description").bold()
            TextEditor(text: $description).frame(width: 325, height: 200).padding().scrollContentBackground(.hidden).background(.quaternary).cornerRadius(10)
            
            Spacer().frame(height: 50)
            Button(action: {
                Task{
                    if description.isEmpty{
                        _ = try await envVar.createTransaction(transaction:Transaction(id: "", name: name , userId: envVar.username, tripId: trip._id, cost: cost, date: envVar.dateToStr(date: date), votesToDelete: [], category: category))
                    }else{
                        _ = try await envVar.createTransaction(transaction:Transaction(id: "", name : name ,userId: envVar.username, tripId: trip._id, cost: cost, date: envVar.dateToStr(date: date), votesToDelete: [], description: description, category: category))
                    }
                    self.transaction = try await envVar.getTransactionsFortrip(trip: self.trip)
                }
                popupBool = false
                
            }, label: {
                Text("Add Transaction").padding().frame(width: 350).background(.tint).foregroundColor(.white).bold()
            }).cornerRadius(10)
            
        }.onAppear(perform: {
            formatter.locale = .current
            formatter.numberStyle = .currency
        })
    }
}
