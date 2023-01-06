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


struct SignInPages_Previews: PreviewProvider {
    static var previews: some View {
        SignInPagesView()
    }
}
