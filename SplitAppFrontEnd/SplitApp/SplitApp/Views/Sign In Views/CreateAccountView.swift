//
//  CreateAccountView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct CreateAccountView: View{
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var fName:String = ""
    @State var lName: String = ""
    @State var email: String = ""
    var body: some View{
        VStack{
            Text("Create an Account").font(.title).padding()
            CustomTextField(width: 250, messageForTextfield: "username", bindingVar: $username).padding()
            CustomTextField(width: 250, messageForTextfield: "password", bindingVar: $password).padding()
            CustomTextField(width: 250, messageForTextfield: "confirm password", bindingVar: $confirmPassword).padding()
            CustomTextField(width: 250, messageForTextfield: "first name", bindingVar: $fName).padding()
            CustomTextField(width: 250, messageForTextfield: "last name", bindingVar: $lName).padding()
            CustomTextField(width: 250, messageForTextfield: "email", bindingVar: $email).padding()
            Button(action: {
                //verify that the password matches and that the username is new and everything is not null
            }, label: {
                Text("Create Account and Sign In").frame(width: 250).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)).background(.tint).foregroundColor(.white).cornerRadius(10).cornerRadius(10)
            })
        }
    }
}
