//
//  TransactionDetail.swift
//  SplitApp
//
//  Created by John Johnston on 1/10/23.
//

import SwiftUI

struct TransactionDetail: View {
    //@EnvironmentObject var envVar: EnviormentVariables
    let transaction: Transaction
    var body: some View {
        VStack{
            Text("Made by: \(transaction.userId)").font(.title3).bold()
            Text("Date of Transaction: \(transaction.date)").font(.title3).bold()
            Text("Cost: $\(transaction.cost)").font(.title3).bold()
            
        }.navigationTitle("Transaction: \(transaction.id)")
    }
}

struct TransactionDetail_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetail(transaction: Transaction(id: "1" , userId: "jjohns49", tripId: "123", cost: 100.58, date: "12-2-27"))
    }
}
