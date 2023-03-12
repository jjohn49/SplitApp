//
//  AllTripsView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct AllTripsView:View{
    @EnvironmentObject var envVars: EnviormentVariables
    @Binding var isNewTripPopUp:Bool
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View{
        ScrollView{
            LazyVGrid(columns: twoColumnGrid){
                ForEach(0..<envVars.trips.count, id: \.self) { x in
                    NavigationLink(destination: {
                        TripDetalView(trip: envVars.trips[x])
                    }, label: {
                        TripRow(trip: envVars.trips[x],width: 175, height: 175).cornerRadius(10)
                    }).foregroundColor(.black)
                }
                
                Button(action: {
                    isNewTripPopUp = true
                }, label: {
                    Label("Add a Trip", systemImage: "plus").frame(width:175,height: 175, alignment: .center).background(.tint).foregroundColor(.white).bold().font(.title3)
                }).cornerRadius(10)
                
            }
        }.padding()
    }
}

