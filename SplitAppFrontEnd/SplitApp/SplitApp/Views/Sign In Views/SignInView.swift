//
//  SignInView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct SignInView: View{
    @State var username: String = ""
    @State var password: String = ""
    @State var createAccountPopUp: Bool = false
    var body: some View{
        VStack{
            CustomTextField(width: 250,messageForTextfield: "username", bindingVar: $username)
            HStack {
                SecureField("password", text: $password)
                Button(action: {
                                password = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.secondary)
                            }
            }.frame(width: 250, alignment: .center).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)).background(.quaternary).cornerRadius(10)
            Button(action: {
                //code to sign in
            }, label: {
                Text("Sign in").frame(width: 250).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)).background(.tint).foregroundColor(.white).cornerRadius(10).cornerRadius(10)
            })
            Button("Create an Account", action: {
                createAccountPopUp = true
            })
                .padding()
            //change the URL to a page that helps you change your password
            Link("Forgot your password?", destination: URL(string: "https://www.google.com")!).frame(width: 300)
        }.popover(isPresented: $createAccountPopUp, content: {
            CreateAccountView()
        })
    }
}
