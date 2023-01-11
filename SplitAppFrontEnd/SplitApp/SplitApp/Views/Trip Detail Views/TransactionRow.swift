//
//  TransactionRow.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI


struct TransactionRow:View{
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var transaction: Transaction
    
    var body: some View{
        NavigationLink(destination: {
            TransactionDetail(transaction: $transaction)
        }, label: {
            HStack {
                VStack{
                    Text("$\(transaction.cost, specifier: "%.2f")").foregroundColor(.black).font(.title2).bold()
                    Text("\(transaction.userId)")
                }
                Spacer()
                Text(envVar.strToDateToStr(strDate: transaction.date))
                if !transaction.votesToDelete.isEmpty{
                    HStack{
                        Text(String(transaction.votesToDelete.count))
                        Image(systemName: "x.circle")
                    }
                }
            }
        })
    }
    
    
}
