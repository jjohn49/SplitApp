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
                TransactionRow(transaction: transaction).swipeActions(content: {
                    Button(transaction.votesToDelete.contains(envVar.username) ? "Vote to keep": "Vote To Delete", action: {
                        Task{
                            try await updateVotesToDelete(transaction: transaction)
                        }
                    }).tint(transaction.votesToDelete.contains(envVar.username) ? .green: .orange)
                })
            }//.onDelete(perform: deleteTransactionRow)
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
    
    func updateVotesToDelete(transaction: Transaction) async throws{
        //add notification support here
        
        var newTransaction: Transaction = transaction
        if transaction.votesToDelete.contains(envVar.username){
            newTransaction.votesToDelete.remove(at: newTransaction.votesToDelete.firstIndex(of: envVar.username)!)
        }else{
            newTransaction.votesToDelete.append(envVar.username)
        }
       
        try await envVar.updateVotesToDelete(transaction: newTransaction)
    }
    
    
}


