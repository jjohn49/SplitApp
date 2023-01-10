//
//  ListOfTransactions.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct ListOfTransactions: View {
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var transactions: [Transaction]
    
    var body: some View {
        List{
            ForEach(transactions.reversed()) { transaction in
                TransactionRow(transaction: transaction)
            }.onDelete(perform: deleteTransactionRow)
        }
    }
    
    func deleteTransactionRow(at offsets: IndexSet){
        let theTransaction = transactions.reversed()[offsets.first!]
        Task{
            let res = try await envVar.deleteTransaction(transaction:theTransaction)
            /*if(res){
                try await getVariablesForTripdetailView()
            }*/
        }
    }
    
    
}


