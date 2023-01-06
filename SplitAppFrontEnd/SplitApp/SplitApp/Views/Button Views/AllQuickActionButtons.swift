//
//  AllQuickActionButtons.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
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
