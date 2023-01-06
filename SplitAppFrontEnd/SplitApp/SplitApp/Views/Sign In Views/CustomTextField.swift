//
//  CustomTextField.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct CustomTextField: View{
    var width: Int
    var messageForTextfield: String
    @Binding var bindingVar: String
    var body: some View{
        HStack {
            TextField(messageForTextfield, text: $bindingVar).autocorrectionDisabled().autocapitalization(.none)
            Button(action: {
                bindingVar = ""
            }) {
                Image(systemName: "multiply.circle.fill").foregroundColor(.secondary)
            }
        }.frame(width: CGFloat(width), alignment: .center).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)).background(.quaternary).cornerRadius(10)
    }
}
