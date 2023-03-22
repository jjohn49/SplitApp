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
    
    

    var body: some View{
        GeometryReader { geo in
            VStack{
                NewTransactionTitle(name: $name).frame(width: geo.size.width - 10)
                
                NewTransactionCostTextView(cost: $cost ).frame(width: geo.size.width - 10)
                
                Picker("Category", selection: $category){
                    ForEach(trip.categories, id: \.self) { category in
                        Text(category)
                    }
                }.pickerStyle(.segmented).padding(.horizontal)
                
                HStack {
                    Text("Date of Transaction:").bold()
                    DatePicker("", selection: $date, displayedComponents: .date)
                }.padding(.horizontal)
                
                Text("Description").bold()
                TextEditor(text: $description).padding().frame(width: geo.size.width - 45).scrollContentBackground(.hidden).background(.quaternary).cornerRadius(10)
                
                //Spacer().frame(height: 50)
                Button(action: {
                    Task{
                        if description.isEmpty{
                            _ = try await envVar.createTransaction(transaction:Transaction(id: "", name: name , userId: envVar.currentUser._id, tripId: trip._id, cost: cost, date: envVar.dateToStr(date: date), votesToDelete: [], category: category))
                        }else{
                            _ = try await envVar.createTransaction(transaction:Transaction(id: "", name : name ,userId: envVar.currentUser._id, tripId: trip._id, cost: cost, date: envVar.dateToStr(date: date), votesToDelete: [], description: description, category: category))
                        }
                        self.transaction = try await envVar.getTransactionsFortrip(trip: self.trip)
                    }
                    
                    DispatchQueue.main.async {
                        popupBool = false
                    }
                    
                    
                }, label: {
                    Text("Add Transaction").padding().frame(width: geo.size.width-45).background(.tint).foregroundColor(.white).bold()
                }).cornerRadius(10)
                
            }
        }
    }
}
