//
//  HomePageView.swift
//  SplitApp
//
//  Created by John Johnston on 10/15/22.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var envVars = EnviormentVariables()
    var body: some View {
        TabView{
            TripsScrollView().tabItem{
                Label("", systemImage: "airplane")
            }
        }.environmentObject(envVars)
    }
}

struct Trip: Identifiable{
    var id : String
    var name: String
    var users: [String]
    var startDate: Date
    var endDate: Date 
}

struct TripsScrollView: View{
    @EnvironmentObject var envVars: EnviormentVariables
    var body: some View{
        NavigationView{
            ScrollView{
                if(envVars.trips.isEmpty){
                    Text("Nothing :(")
                }else{
                    ForEach(envVars.trips){ trip in
                        NavigationLink(destination: TripDetalView(trip: trip), label: {
                            TripRow(name: trip.name, users: trip.users).foregroundColor(.black)
                        }).cornerRadius(10)
                        
                    }
                }
            }.navigationTitle("Trips")
        }
    }
}

struct TripDetalView:View{
    let trip: Trip
    var body: some View{
        ScrollView{
            Text("Hello")
        }.navigationTitle(trip.name)
    }
}

struct TripRow: View{
    var name: String
    var users:[String]
    var body: some View{
        VStack{
            Text(name).bold().font(.title).frame(alignment: .leading)
            Text("with: " + users.joined(separator: ", "))
        }.frame(width:350,height: 300).background(.quaternary)
    }
}

struct TripRowGraphic: View{
    let trip: Trip
    var body: some View{
        Text("Placeholder")
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


