//
//  TripRow.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct TripRow: View{
    @EnvironmentObject var envVar: EnviormentVariables
    let trip: Trip
    var width: CGFloat = 250
    var height: CGFloat = 250
    var body: some View{
        VStack{
            Text(trip.name).bold().font(.title).frame(alignment: .leading)
            Text("with: " + trip.users.joined(separator: ", "))
        }.frame(width:width,height: height).background(envVar.strToDate(strDate: trip.endDate) > envVar.dateToStrToDate(date: Date.now) ? .green : .red)
    }
}
