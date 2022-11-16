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
            TripsView().tabItem{
                Label("", systemImage: "airplane").font(.title2)
            }
        }.environmentObject(envVars).onAppear(perform: envVars.getAllTripsForUser)
    }
}



struct TripsView: View{
    @EnvironmentObject var envVars: EnviormentVariables
    var views: [String] = ["Current Trips", "All Trips"]
    @State var view: String = "Current Trip"
    @State var isNewTripPopUp: Bool = false
    var body: some View{
        NavigationView {
            VStack {
                if(view==views[1]){
                    AllTripsView(isNewTripPopUp: $isNewTripPopUp,trips: envVars.trips)
                }else{
                    TripsScrollView(isNewTripPopUp: $isNewTripPopUp)
                }
                
            }.navigationTitle("Trips").toolbar(content: {
                HStack {
                    Picker("Menu", selection: $view, content: {
                        ForEach(views, id: \.self, content: { view in
                            Text(view)
                        })
                    })
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
                }
            }).popover(isPresented: $isNewTripPopUp, content: {
                ZStack{
                    AddTripView()
                }
            })
        }
    }
}

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

struct TripsScrollView: View{
    @EnvironmentObject var envVars: EnviormentVariables
    //made vars for each because it was less complicated then dealing with popovers
    @Binding var isNewTripPopUp: Bool
    var body: some View{
        VStack {
            HorizontalTrips(popOver: $isNewTripPopUp).padding()
            Spacer()
            AllQuickActionButtons()
            Spacer()
            Button(action: {
                isNewTripPopUp = true
            }, label: {
                Text("Make a new Trip").padding().frame(width: 350).background(.tint).foregroundColor(.white).bold()
            }).cornerRadius(10)
            Spacer()
        }
        
    }
}


struct AddTripView:View{
    @State var tripName: String = ""
    @State var user: String = ""
    @State var users:[String] = []
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date.now
    var body: some View{
        VStack{
            InputTripName(tripName: $tripName)
            Spacer()
            InputUsers(user: $user, users: $users)
            Spacer()
            InputStartAndEdDates(startdate: $startDate, endDate: $endDate)
            Button(action: {
                //create trip
            }, label: {
                Text("Creat Trip").padding().frame(width: 350).foregroundColor(.white).background(.tint)
            }).cornerRadius(10)
        }
    }
}

struct InputTripName: View{
    @Binding var tripName:String
    
    var body: some View{
        HStack {
            TextField("Trip Name", text: $tripName).font(.largeTitle).bold().padding()
            Button(action: {
                tripName = ""
            }, label: {
                Image(systemName: "multiply.circle.fill").foregroundColor(.secondary).padding()
            })
        }.frame(width: 350).background(.quaternary).cornerRadius(10).padding()
    }
}

struct InputUsers: View{
    @Binding var user: String
    @Binding var users: [String]
    var body: some View{
        VStack {
            HStack{
                Text("Users:").font(.title2).bold().padding()
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(users, id: \.self){ u in
                            HStack{
                                Text(u)
                                Button(action: {
                                    users.remove(at: users.firstIndex(of: u)!)
                                }, label: {
                                    Image(systemName: "multiply.circle.fill").foregroundColor(.secondary).padding()
                                })
                            }
                        }
                    }
                }.frame(height: 50)
            }
            HStack{
                TextField("add user", text: $user).padding()
                Button(action: {
                    if !(users.contains(user) && user.elementsEqual("")){
                        users.append(user)
                    }
                    
                }, label: {
                    Text("Add user").padding()
                }).foregroundColor(.white).background(.blue).cornerRadius(10)
            }.padding().background(.quaternary).cornerRadius(10)
        }.frame(width: 350)
    }
}

struct InputStartAndEdDates:View{
    @EnvironmentObject var envVar: EnviormentVariables
    @State var dates: Set<DateComponents> = []
    @Binding var startdate: Date
    @Binding var endDate: Date
    
    var body: some View{
        VStack{
            Text("\(envVar.dateToStr(date: startdate)) -> \(envVar.dateToStr(date: endDate))")
            MultiDatePicker("Start and end Dates", selection: $dates).datePickerStyle(.automatic)
        }.padding()
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
                    Label("Add a Trip", systemImage: "plus").frame(width:350,height: 275, alignment: .center).background(.tint).foregroundColor(.white).bold().font(.title)
                }).cornerRadius(10).scrollDisabled(true)
            }else if(envVars.trips.count == 1){
                NavigationLink(destination: TripDetalView(trip: envVars.trips[0]), label: {
                    TripRow(trip: envVars.trips[0], width: 350, height: 275).foregroundColor(.black)
                }).cornerRadius(10)
            }
            else{
                HStack {
                    ForEach(envVars.trips){ trip in
                        NavigationLink(destination: TripDetalView(trip: trip), label: {
                            TripRow(trip: trip).foregroundColor(.black)
                        }).cornerRadius(10)
                    }
                }
            }
        }.scrollDismissesKeyboard(.automatic)
    }
}


struct TripRow: View{
    let trip: Trip
    var width: CGFloat = 300
    var height: CGFloat = 300
    var body: some View{
        VStack{
            Text(trip.name).bold().font(.title).frame(alignment: .leading)
            Text("with: " + trip.users.joined(separator: ", "))
        }.frame(width:width,height: height).background(.quaternary)
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}



