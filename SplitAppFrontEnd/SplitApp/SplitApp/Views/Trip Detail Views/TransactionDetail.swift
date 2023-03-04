//
//  TransactionDetail.swift
//  SplitApp
//
//  Created by John Johnston on 1/10/23.
//

import SwiftUI

struct TransactionDetail: View {
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var transaction: Transaction
    var body: some View {
        VStack{
            Text("Made by: \(transaction.userId)").font(.title3).bold()
            Text("Date of Transaction: \(transaction.date)").font(.title3).bold()
            Text("Cost: $\(transaction.cost)").font(.title3).bold()
            if transaction.description != nil{
                Text("Description: ")
                Text(transaction.description!)
            }
            
            isOnlyOnePerson() ? AnyView(DeleteTreansactionButton(transaction: $transaction)) : AnyView(TransactionVoteSwipAction(transaction: $transaction))
        }.navigationTitle("Transaction: \(transaction.id)")
    }
    
    func isOnlyOnePerson() -> Bool{
        return envVar.trips.first(where: {$0._id == transaction.tripId})!.users.count == 1
    }
}


struct DeleteTreansactionButton: View{
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var transaction: Transaction
    var body: some View{
        Button("Delete", action: {
            
            Task{
               try await deleteTransactionRow(transaction: transaction)
            }
        }).tint(.red)
    }
    
    func deleteTransactionRow(transaction: Transaction) async throws{
        _ = withAnimation{
            Task{
                _ = try await envVar.deleteTransaction(transaction: transaction)
            }
        }
    }
}


