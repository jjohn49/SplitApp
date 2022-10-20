//
//  HomePageView.swift
//  SplitApp
//
//  Created by John Johnston on 10/15/22.
//

import SwiftUI
import Charts

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
    @State var isNewTripPopUp: Bool = false
    var body: some View{
        NavigationView{
            VStack {
                HorizontalTrips().navigationTitle("Trips").padding()
                
                
                Spacer()
                Button(action: {
                    isNewTripPopUp = true
                }, label: {
                    Text("Make a new Trip").padding().frame(width: 350).background(.tint).foregroundColor(.white).bold()
                }).cornerRadius(10)
                Spacer()
            }
        }.popover(isPresented: $isNewTripPopUp, content: {
            AddTripView()
        })
    }
}

struct AddTripView:View{
    @State var tripName: String = ""
    @State var users = []
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date.now
    var body: some View{
        VStack{
            CustomTextField(width: 300, messageForTextfield: "Trip Name", bindingVar: $tripName)
        }
    }
}

struct ChartView:View{
    var body: some View{
        Chart{
            BarMark(x: .value("", 0), y: .value("", 100), width: 40)
            BarMark(x: .value("", 2), y: .value("", 1))
        }
    }
}

struct HorizontalTrips:View{
    @EnvironmentObject var envVars: EnviormentVariables
    var body: some View{
        ScrollView(.horizontal){
            if(envVars.trips.isEmpty){
                Text("Nothing :(")
            }else{
                HStack {
                    ForEach(envVars.trips){ trip in
                        NavigationLink(destination: TripDetalView(trip: trip), label: {
                            TripRow(name: trip.name, users: trip.users).foregroundColor(.black)
                        }).cornerRadius(10)
                        
                    }
                }
            }
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
        }.frame(width:300,height: 300).background(.quaternary)
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


