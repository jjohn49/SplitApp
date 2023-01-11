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
            ForEach(transactions.indices) { index in
                TransactionRow(transaction: $transactions[index]).swipeActions(content: {
                    Button(didUserVoteToDelete(transaction: transactions[index]) ? "Vote to keep": "Vote To Delete", action: {
                        if didUserVoteToDelete(transaction: transactions[index]) {
                            transactions[index].votesToDelete.remove(at: transactions[index].votesToDelete.firstIndex(of: envVar.username)!)
                        } else{
                            transactions[index].votesToDelete.append(envVar.username)
                        }
                        Task{
                            var temp = transactions[index]
                            try await updateVotesToDelete(transaction: temp)
                        }
                    }).tint(didUserVoteToDelete(transaction: transactions[index]) ? .green: .orange)
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
        try await envVar.updateVotesToDelete(transaction: newTransaction)
        //transactions = try await envVar.getTransactionsFortrip(trip: envVar.currentTrip!)
    }
    
    func didUserVoteToDelete(transaction: Transaction) -> Bool{
        return transaction.votesToDelete.contains(envVar.username)
    }
    
    
}


