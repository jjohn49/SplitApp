//
//  MostRecentTransactions.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct MostRecentTransactions: View {
    @Binding var transactions: [Transaction]
    var body: some View {
        VStack{
            if transactions.isEmpty{
                Text("No Transactions")
            }
            else{
                HStack(alignment: .top){
                    Text("Most Recent").font(.headline)
                    Spacer()
                    NavigationLink(destination: {
                        ListOfTransactions(transactions: $transactions)
                    }, label: {
                        Image(systemName: "arrow.up.backward.and.arrow.down.forward.circle.fill").resizable().frame(width:40,height: 40)
                    })
                }
                
                TransactionRow(transaction: $transactions[0])
                if(transactions.count>2){
                    TransactionRow(transaction: $transactions[1])
                    if(transactions.count>3){
                        TransactionRow(transaction: $transactions[2])
                    }
                }else{
                    Spacer()
                }
                
            }
        }.padding()
    }
}



