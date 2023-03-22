//
//  NewTransactionCostTextView.swift
//  SplitApp
//
//  Created by John Johnston on 3/18/23.
//

import SwiftUI

struct NewTransactionCostTextView: View {
    
    @Binding var cost:Double
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        HStack {
            TextField("0.00", value: $cost, formatter: formatter).font(.largeTitle).bold().padding().keyboardType(.numberPad)
            Button(action: {
                cost = 0.00
            }, label: {
                Image(systemName: "multiply.circle.fill").foregroundColor(.secondary).padding()
            })
        }.background(.quaternary).cornerRadius(10).padding(.horizontal)
    }
}


