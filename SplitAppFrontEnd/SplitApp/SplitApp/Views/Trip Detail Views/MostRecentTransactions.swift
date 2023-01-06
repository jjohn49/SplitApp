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
            Text("Most Recent").font(.caption)
            if transactions.count < 4{
                ForEach(transactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }else{
                TransactionRow(transaction: transactions.last!)
                TransactionRow(transaction: transactions[transactions.count - 2])
                TransactionRow(transaction: transactions[transactions.count - 3])
            }
        }
    }
}



