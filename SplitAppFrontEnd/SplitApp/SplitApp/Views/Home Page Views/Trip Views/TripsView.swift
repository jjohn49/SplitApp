//
//  TripsView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct TripsView: View {
    @EnvironmentObject var envVars: EnviormentVariables
    var views: [String] = ["Current Trips", "All Trips"]
    @State var view: String = "Current Trip"
    @State var isNewTripPopUp: Bool = false
    var body: some View{
        VStack {
            AllTripsView(isNewTripPopUp: $isNewTripPopUp)
        }.popover(isPresented: $isNewTripPopUp, content: {
            ZStack{
                AddTripView()
            }
        })
        
    }
}

