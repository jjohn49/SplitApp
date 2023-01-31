//
//  VoteToEndTripButton.swift
//  SplitApp
//
//  Created by John Johnston on 1/31/23.
//

import SwiftUI

struct VoteToEndTripButton: View{
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var trip: Trip
    var body: some View{
        Button(action: {
            Task{
                if !trip.votesToEndTrip.contains(envVar.username){
                    trip.votesToEndTrip.append(envVar.username)
                    _ = try await envVar.updateVotesToDeleteTrip(trip: trip)
                }
                
                if(trip.votesToEndTrip.count == trip.users.count){
                    envVar.trips.removeAll(where: {$0._id == trip._id})
                }
                
                
            }
        }, label: {
            Text("Vote to End the Trip").padding()
        }).frame(width: 350).background(.orange).foregroundColor(Color("wb")).cornerRadius(10)
    }
}

