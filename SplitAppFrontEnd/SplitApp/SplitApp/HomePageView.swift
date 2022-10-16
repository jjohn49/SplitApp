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

struct trip: Identifiable{
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
                        NavigationLink(destination: TripDetalView(), label: {
                            TripRow(name: trip.name, users: trip.users).foregroundColor(.black)
                        })
                        
                    }
                }
            }.navigationTitle("Trips")
        }
    }
}

struct TripDetalView:View{
    var body: some View{
        Text("This works")
    }
}

struct TripRow: View{
    var name: String
    var users:[String]
    var body: some View{
        VStack{
            Text(name).bold().font(.title).frame(alignment: .leading)
            Text("with: " + users.joined(separator: ", "))
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct Previews_HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

struct Previews_HomePageView_Previews_2: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
