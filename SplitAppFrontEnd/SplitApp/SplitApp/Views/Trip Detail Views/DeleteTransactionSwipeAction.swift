//
//  DeleteTransactionSwipeAction.swift
//  SplitApp
//
//  Created by John Johnston on 1/11/23.
//

import SwiftUI

struct DeleteTransactionSwipeAction: View {
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var transactions: [Transaction]
    let index: Int
    var body: some View {
        Button("Delete", action: {
            let temp = transactions[index]
            transactions.remove(at: index)
            Task{
               try await deleteTransactionRow(transaction: temp)
            }
        }).tint(.red)
    }
    
    func deleteTransactionRow(transaction: Transaction) async throws{
        Task{
            let res = try await envVar.deleteTransaction(transaction: transaction)
        }
    }
}
