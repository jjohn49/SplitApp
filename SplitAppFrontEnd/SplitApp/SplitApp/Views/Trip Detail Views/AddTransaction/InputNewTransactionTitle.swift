//
//  InputNewTransactionTitle.swift
//  SplitApp
//
//  Created by John Johnston on 3/18/23.
//

import SwiftUI

struct NewTransactionTitle: View {
    @Binding var name: String
    var body: some View {
        TextField("Name", text: $name).font(.largeTitle).bold().padding().background(.quaternary).cornerRadius(10).padding()
    }
}


