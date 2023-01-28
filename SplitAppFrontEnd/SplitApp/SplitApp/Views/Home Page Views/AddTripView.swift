//
//  AddTripView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct AddTripView:View{
    @EnvironmentObject var envVar: EnviormentVariables
    @State var trip: Trip = Trip(_id: "", name: "", users: [], startDate: "", endDate: "", categories: ["Clothes","Food","Merch","Others"], votesToEndTrip: [])
    var tripName: String?
    var body: some View{
        VStack{
            InputTripName(tripName: $trip.name).onAppear(perform: {
                if tripName != nil{
                    trip.name = tripName!
                }
            })
            
            InputStartAndEdDates(startDate: $trip.startDate, endDate: $trip.endDate).onAppear(perform: {
                trip.startDate = envVar.dateToStr(date: Date.now)
                trip.endDate = envVar.dateToStr(date: Date.now)
            })
            
            InputUsers(users: $trip.users)
            
            
            
            Spacer()
            
            Button(action: {
                Task{
                    let _ = try await envVar.createTrip(trip: trip)
                    let _ = envVar.getAllTripsForUser()
                }
            }, label: {
                Text("Create Trip").padding().frame(width: 350).foregroundColor(.white).background(.tint)
            }).cornerRadius(10)
        }.onAppear(perform: {
            trip.users.append(envVar.username)
        })
    }
}

struct AddTripView_Previews: PreviewProvider {
    static var previews: some View {
        AddTripView()
    }
}
