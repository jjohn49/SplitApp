//
//  TransactionVoteSwipAction.swift
//  SplitApp
//
//  Created by John Johnston on 1/11/23.
//

import SwiftUI

struct TransactionVoteSwipAction: View {
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var transaction: Transaction
    var body: some View {
        Button(didUserVoteToDelete(transaction: transaction) ? "Vote to keep": "Vote To Delete", action: {
            if didUserVoteToDelete(transaction: transaction) {
                transaction.votesToDelete.remove(at: transaction.votesToDelete.firstIndex(of: envVar.username)!)
            } else{
                transaction.votesToDelete.append(envVar.username)
            }
            Task{
                try await updateVotesToDelete(transaction: transaction)
            }
        }).tint(didUserVoteToDelete(transaction: transaction) ? .green: .orange)
    }
    
    func updateVotesToDelete(transaction: Transaction) async throws{
        //add notification support here
        
        let newTransaction: Transaction = transaction
        try await envVar.updateVotesToDelete(transaction: newTransaction)
    }

    func didUserVoteToDelete(transaction: Transaction) -> Bool{
        return transaction.votesToDelete.contains(envVar.username)
    }
}


