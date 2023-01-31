//
//  ButtonStyleInQuickActionButton.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct ButtonStyleInQuickActionButton:View{
    let emoji: String
    let message: String
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 90).foregroundColor(Color("gray"))
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 5).frame(width: 100, height: 90).background(LinearGradient(colors: [Color("purple"), Color("blue")], startPoint: .bottomLeading, endPoint: .topTrailing)).foregroundColor(.clear).cornerRadius(10)
            
            //RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).frame(width: 100, height: 90)
            VStack{
                Text(emoji).font(.title2)
                Text(message).font(.subheadline)
            }
        }
    }
}
