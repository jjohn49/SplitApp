//
//  InputTripName.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct InputTripName: View{
    @Binding var tripName:String
    
    var body: some View{
        HStack {
            TextField("Trip Name", text: $tripName).font(.largeTitle).bold().padding()
            Button(action: {
                tripName = ""
            }, label: {
                Image(systemName: "multiply.circle.fill").foregroundColor(.secondary).padding()
            })
        }.frame(width: 350).background(.quaternary).cornerRadius(10).padding()
    }
}
