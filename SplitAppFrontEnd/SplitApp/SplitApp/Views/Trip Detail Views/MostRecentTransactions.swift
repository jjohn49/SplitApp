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
            else if transactions.count < 4{
                Text("All Transactions").font(.caption)
                ForEach($transactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }else{
                HStack {
                    Text("Most Recent").font(.headline)
                    Spacer()
                    NavigationLink(destination: {
                        ListOfTransactions(transactions: $transactions)
                    }, label: {
                        Image(systemName: "arrow.up.backward.and.arrow.down.forward.circle.fill").resizable().frame(width:40,height: 40)
                    })
                }
                
                TransactionRow(transaction: $transactions.last!)
                TransactionRow(transaction: $transactions[transactions.count - 2])
                TransactionRow(transaction: $transactions[transactions.count - 3])
                
            }
        }.padding()
    }
}



