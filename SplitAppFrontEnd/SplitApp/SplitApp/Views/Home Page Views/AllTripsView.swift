//
//  AllTripsView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct AllTripsView:View{
    @Binding var isNewTripPopUp:Bool
    var trips: [Trip]
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View{
        ScrollView{
            LazyVGrid(columns: twoColumnGrid){
                ForEach(0..<trips.count) { x in
                    NavigationLink(destination: {
                        TripDetalView(trip: trips[x])
                    }, label: {
                        TripRow(trip: trips[x],width: 175, height: 175).cornerRadius(10)
                    })
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

