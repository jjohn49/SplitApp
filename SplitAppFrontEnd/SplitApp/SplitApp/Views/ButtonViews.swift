//
//  ButtonViews.swift
//  SplitApp
//
//  Created by John Johnston on 11/5/22.
//

import SwiftUI


struct AllQuickActionButtons:View{
    //This was easier than making one popover with conditions
    //multiple popovers with different binding values
    @State var isNightOut: Bool = false
    @State var isBar: Bool = false
    @State var isAdventure: Bool = false
    @State var isRoadTrip: Bool = false
    @State var isBusiness: Bool = false
    @State var isVacation: Bool = false
    var body: some View{
        VStack{
            HStack{
                Spacer()
                QuickActionButton(isNewTripPopUp: $isNightOut, emoji: "🍸", message: "Cocktails")
                Spacer()
                QuickActionButton(isNewTripPopUp: $isBar, emoji: "🍻", message: "Bar")
                Spacer()
                QuickActionButton(isNewTripPopUp: $isAdventure, emoji: "🤠", message: "Quest")
                Spacer()
            }.padding()
            
            HStack{
                Spacer()
                QuickActionButton(isNewTripPopUp: $isRoadTrip, emoji: "🚘", message: "Road")
                Spacer()
                QuickActionButton(isNewTripPopUp: $isBusiness, emoji: "💼", message: "Business")
                Spacer()
                QuickActionButton(isNewTripPopUp: $isVacation, emoji: "🏖", message: "Vacation")
                Spacer()
            }.padding()
        }
    }
}

struct QuickActionButton:View{
    @Binding var isNewTripPopUp: Bool
    let emoji: String
    let message: String
    var body: some View{
        Button(action: {
            isNewTripPopUp = true
        }, label: {
            ButtonStyleInQuickActionButton(emoji: emoji, message: message)
        }).foregroundColor(.gray).popover(isPresented: $isNewTripPopUp, content: {
            AddTripView(tripName: message)
        })

    }
}
struct ButtonStyleInQuickActionButton:View{
    let emoji: String
    let message: String
    var body: some View{
        ZStack{
            Circle().frame(width: 100, height: 70).foregroundColor(.blue)
            Circle().stroke(lineWidth: 3).frame(width: 100, height: 70)
            VStack{
                Text(emoji).font(.title2)
                Text(message).font(.subheadline)
            }.foregroundColor(.white)
        }
    }
}



