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
                Text(emoji).font(.title2)
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




//https://www.appcoda.com/swiftui-line-charts/
struct ChartView:View{
    let transactions: [Transaction]
    var body: some View{
        Chart{
            ForEach(transactions) { transaction in
                LineMark(x: .value("Date", strToDateToStr(transaction: transaction)), y: .value("Cost", 0))
            }
        }.frame(width: 375, height: 200)
    }
    
    
    
    
    func strToDate(transaction: Transaction) -> Date{
        let format = DateFormatter()
        format.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'000Z"
        return format.date(from: transaction.date)!
    }
    
    func strToDateToStr(transaction: Transaction) -> String {
        let date = strToDate(transaction: transaction)
        let format = DateFormatter()
        format.dateFormat = "MM/dd"
        return format.string(from: date)
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

struct TripDetalView:View{
    @EnvironmentObject var envVar: EnviormentVariables
    
    let trip: Trip
    @State var transactions: [Transaction] = []
    var body: some View{
        ScrollView{
            ChartView(transactions: transactions).frame(width: 400,height: 200)
            Text("Transactions").font(.title).bold()
            List{
                ForEach(transactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
                
            }.frame(height: 400)
        }.navigationTitle(trip.name).onAppear(perform: {
            Task{
                do{
                    self.transactions = try await envVar.getTransactionsFortrip(trip: trip)
                    print(self.transactions)
                }catch let error{
                    print(error)
                }
            }
        })
    }
}

struct TransactionRow:View{
    let transaction: Transaction
    
    var body: some View{
        HStack {
            VStack{
                Text("$\(transaction.cost, specifier: "%.2f")").foregroundColor(.black).font(.title2).bold()
                Text("\(transaction.userId)")
                
            }
            Spacer()
            Text(strToDateToStr())
        }
    }
    
    func strToDate() -> Date{
        let format = DateFormatter()
        format.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'000Z"
        return format.date(from: self.transaction.date)!
    }
    
    func strToDateToStr() -> String {
        let date = strToDate()
        let format = DateFormatter()
        format.dateFormat = "MM/dd"
        return format.string(from: date)
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



