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
            ForEach(transactions.indices, id:\.self) { index in
                TransactionRow(transaction: $transactions[index]).swipeActions(content: {
                    isOnlyOnePerson() ? AnyView(DeleteTransactionSwipeAction(transactions: $transactions, index: index)) : AnyView(TransactionVoteSwipAction(transaction: $transactions[index]))
                })
            }
        }
    }
    
    func isOnlyOnePerson() -> Bool{
        return envVar.currentTrip!.users.count == 1
    }
    
    
    
    
    
    
}


