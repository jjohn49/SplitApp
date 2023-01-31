//
//  QuickActionButton.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct QuickActionButton:View{
    @Binding var isNewTripPopUp: Bool
    let emoji: String
    let message: String
    var body: some View{
        Button(action: {
            isNewTripPopUp = true
        }, label: {
            ButtonStyleInQuickActionButton(emoji: emoji, message: message)
        }).foregroundColor(Color("wb")).popover(isPresented: $isNewTripPopUp, content: {
            AddTripView(tripName: message)
        })

    }
}
