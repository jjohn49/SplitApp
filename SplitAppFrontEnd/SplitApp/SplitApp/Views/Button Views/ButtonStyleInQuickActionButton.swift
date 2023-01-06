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
            RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 90).foregroundColor(.blue)
            //RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).frame(width: 100, height: 90)
            VStack{
                Text(emoji).font(.title2)
                Text(message).font(.subheadline)
            }.foregroundColor(.white)
        }
    }
}
