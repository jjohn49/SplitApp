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
    //made vars for each because it was less complicated then dealing with popovers
    @State var isNewTripPopUp: Bool = false
    
    var body: some View{
        NavigationView{
            VStack {
                HorizontalTrips(popOver: $isNewTripPopUp).padding()
                
                AllQuickActionButtons()
                Button(action: {
                    isNewTripPopUp = true
                }, label: {
                    Text("Make a new Trip").padding().frame(width: 350).background(.tint).foregroundColor(.white).bold()
                }).cornerRadius(10)
                Spacer()
            }.popover(isPresented: $isNewTripPopUp, content: {
                ZStack{
                    AddTripView()
                }
                
            }).navigationTitle("Trips").toolbar(content: {
                Menu(content: {
                    Button(action: {
                        
                    }, label: {
                        Text("Account")
                    })
                    Button(action: {
                        
                    }, label: {
                        Text("Settings")
                    })
                }, label: {
                    ZStack {
                        Image(systemName: "person.crop.circle").font(.largeTitle).bold()
                    }
                })
            })
        }
    }
}

struct AllQuickActionButtons:View{
    //This was easier than making one popover with conditions
    //multiple popovers with different binding values
    @State var isNightOut: Bool = false
    @State var isBar: Bool = false
    @State var isAdventure: Bool = false
    @State var isRoadTrip: Bool = false
    @State var isBusiness: Bool = false
    @State var isVacation: Bool = false
    var body: some View{
        VStack{
            HStack{
                Spacer()
                QuickActionButton(isNewTripPopUp: $isNightOut, emoji: "🍸", message: "Cocktails")
                Spacer()
                QuickActionButton(isNewTripPopUp: $isBar, emoji: "🍻", message: "Bar")
                Spacer()
                QuickActionButton(isNewTripPopUp: $isAdventure, emoji: "🤠", message: "Quest")
                Spacer()
            }.padding()
            
            HStack{
                Spacer()
                QuickActionButton(isNewTripPopUp: $isRoadTrip, emoji: "🚘", message: "Road")
                Spacer()
                QuickActionButton(isNewTripPopUp: $isBusiness, emoji: "💼", message: "Business")
                Spacer()
                QuickActionButton(isNewTripPopUp: $isVacation, emoji: "🏖", message: "Vacation")
                Spacer()
            }.padding()
        }
    }
}

struct QuickActionButton:View{
    @Binding var isNewTripPopUp: Bool
    let emoji: String
    let message: String
    var body: some View{
        Button(action: {
            isNewTripPopUp = true
        }, label: {
            ButtonStyleInQuickActionButton(emoji: emoji, message: message)
        }).foregroundColor(.gray).popover(isPresented: $isNewTripPopUp, content: {
            AddTripView(tripName: message)
        })

    }
}
struct ButtonStyleInQuickActionButton:View{
    let emoji: String
    let message: String
    var body: some View{
        ZStack{
            Circle().frame(width: 100, height: 70).foregroundColor(.blue)
            Circle().stroke(lineWidth: 3).frame(width: 100, height: 70)
            VStack{
                Text(emoji).font(.title)
                Text(message).font(.subheadline)
            }.foregroundColor(.white)
        }
    }
}

struct AddTripView:View{
    @State var tripName: String = ""
    @State var users = []
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date.now
    var body: some View{
        VStack{
            InputTripName(tripName: $tripName)
            
            Spacer()
        }
    }
}

struct InputTripName: View{
    @Binding var tripName:String
    var body: some View{
        if(tripName==""){
            HStack {
                TextField("Trip Name", text: $tripName).font(.largeTitle).bold().padding()
                Button(action: {
                    tripName = ""
                }, label: {
                    Image(systemName: "multiply.circle.fill").foregroundColor(.secondary).padding()
                })
            }.frame(width: 350).background(.quaternary).cornerRadius(10).padding()
        }else{
            HStack {
                TextField(tripName, text: $tripName).font(.largeTitle).bold().padding()
                Button(action: {
                    tripName = ""
                }, label: {
                    Image(systemName: "multiply.circle.fill").foregroundColor(.secondary).padding()
                })
            }.frame(width: 350).background(.quaternary).cornerRadius(10).padding()
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
    @Binding var popOver: Bool
    var body: some View{
        ScrollView(.horizontal){
            if(envVars.trips.isEmpty){
                Button(action: {
                    popOver = true
                }, label: {
                    Label("Add a Trip", systemImage: "plus").frame(width:350,height: 300, alignment: .center).background(.tint).foregroundColor(.white).bold().font(.title)
                }).cornerRadius(10).scrollDisabled(true)
            }else if(envVars.trips.count == 1){
                NavigationLink(destination: TripDetalView(trip: envVars.trips[0]), label: {
                    TripRow(name: envVars.trips[0].name, users: envVars.trips[0].users, width: 350).foregroundColor(.black)
                }).cornerRadius(10)
            }
            else{
                HStack {
                    ForEach(envVars.trips){ trip in
                        NavigationLink(destination: TripDetalView(trip: trip), label: {
                            TripRow(name: trip.name, users: trip.users).foregroundColor(.black)
                        }).cornerRadius(10)
                    }
                }
            }
        }.scrollDismissesKeyboard(.automatic)
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
    var width: CGFloat = 300
    var height: CGFloat = 300
    var body: some View{
        VStack{
            Text(name).bold().font(.title).frame(alignment: .leading)
            Text("with: " + users.joined(separator: ", "))
        }.frame(width:width,height: height).background(.quaternary)
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


