//
//  SignInPages.swift
//  SplitApp
//
//  Created by John Johnston on 10/15/22.
//

import SwiftUI


struct SignInPagesView:View{
    var body:some View{
        VStack {
            Spacer().frame(height: 50)
            Circle().frame(width: 200).padding()
            Text("Welcome to SplitApp").font(.title).padding()
            SignInView()
            Spacer()
        }
    }
}

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
struct SignInPages_Previews: PreviewProvider {
    static var previews: some View {
        SignInPagesView()
    }
}
