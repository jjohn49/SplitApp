//
//  TripsScrollView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct TripsScrollView: View{
    @EnvironmentObject var envVars: EnviormentVariables
    //made vars for each because it was less complicated then dealing with popovers
    @Binding var isNewTripPopUp: Bool
    var body: some View{
        VStack {
            HorizontalTrips(popOver: $isNewTripPopUp).padding()
            Spacer()
            AllQuickActionButtons()
            Spacer()
            Button(action: {
                isNewTripPopUp = true
            }, label: {
                Text("Make a new Trip").padding().frame(width: 350).background(.tint).foregroundColor(.white).bold()
            }).cornerRadius(10)
            Spacer()
        }
        
    }
}


