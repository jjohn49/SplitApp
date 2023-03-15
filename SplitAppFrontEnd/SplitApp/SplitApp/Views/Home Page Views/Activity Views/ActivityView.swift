//
//  ActivityView.swift
//  SplitApp
//
//  Created by John Johnston on 3/3/23.
//

import SwiftUI

struct ActivityView: View{
    
    @EnvironmentObject var envVars: EnviormentVariables
    
    var body: some View{
        GeometryReader { geo in
            ScrollView{
                
                ActivityHeader(geo: geo).padding()
                
                ForEach($envVars.allTransactions){ $transaction in
                    ActivityTransactionRow(transaction: $transaction, width: geo.size.width * 0.9, height: geo.size.height * 0.15)
                }
                
                Text("You're All Caught Up")
                
            }.refreshable {
                Task {
                    
                    try await envVars.refreshEnvVars()
                }
            }
        }
        
    }
}

struct ActivityHeader:View{
    let geo: GeometryProxy
    var body: some View{
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15).foregroundColor(Color("blue"))
                Text("Activity").font(.largeTitle).bold().padding()
            }
            Spacer()
            Image(systemName: "person.crop.circle").font(.largeTitle).bold().frame(width: 100,height: 100)
        }.frame(height: 100)
    }
}

struct ActivityTransactionRow: View{
    @EnvironmentObject var envVars: EnviormentVariables
    @Binding var transaction: Transaction
    let width: CGFloat
    let height: CGFloat
    var body: some View{
        NavigationLink(destination: TransactionDetail(transaction: $transaction).environmentObject(envVars)){
            ZStack {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("gray"))
                VStack{
                    HStack{
                        VStack {
                            Image(systemName: "person.crop.circle").font(.largeTitle).bold()
                            Text(transaction.userId)
                        }.padding()
                        Spacer()
                        VStack {
                            Text("$ \(transaction.cost, specifier: "%.2f")").font(.largeTitle).bold()
                            Text("\(transaction.name) for \(envVars.trips.first(where: { $0._id == transaction.tripId})?.name ?? "None")")
                        }.padding()
                    }
                }
            }.frame(width: width, height: height)
        }
    }
}
