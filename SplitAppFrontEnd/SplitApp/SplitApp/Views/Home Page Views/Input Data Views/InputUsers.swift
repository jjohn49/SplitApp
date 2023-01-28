//
//  InputUsers.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI


struct InputUsers: View{
    @EnvironmentObject var envVars: EnviormentVariables
    @State var user: String = ""
    @Binding var users: [String]
    var body: some View{
        VStack {
            HStack{
                Text("Users:").font(.title2).bold().padding()
                ScrollView(.horizontal){
                    LazyHStack{
                        Text(envVars.username)
                        ForEach(users, id: \.self){ u in
                            HStack{
                                Text(u)
                                Button(action: {
                                    users.remove(at: users.firstIndex(of: u)!)
                                }, label: {
                                    Image(systemName: "multiply.circle.fill").foregroundColor(.secondary)
                                })
                            }.padding().background(.quaternary).cornerRadius(10)
                        }
                    }
                }.frame(height: 50)
            }
            HStack{
                TextField("add user by username", text: $user).padding().textInputAutocapitalization(.never)
                Button(action: {
                    if !(users.contains(user) && user.elementsEqual("")){
                        users.append(user)
                        user = ""
                    }
                    
                }, label: {
                    Text("Add user").padding()
                }).foregroundColor(.white).background(.blue).cornerRadius(10)
            }.padding().background(.quaternary).cornerRadius(10)
        }.frame(width: 350)
    }
}
