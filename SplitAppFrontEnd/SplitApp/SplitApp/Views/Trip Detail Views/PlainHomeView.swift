//
//  PlainHomeView.swift
//  SplitApp
//
//  Created by John Johnston on 1/31/23.
//

import SwiftUI
import Charts

struct PlainHomeView: View {
    var trips:[Trip] = [Trip(_id: "1", name: "Montreal", users: ["me"], startDate: "9-22-2002", endDate: "", votesToEndTrip: []),
                        Trip(_id: "2", name: "Vegas", users: ["me"], startDate: "9-22-2002", endDate: "", votesToEndTrip: []),
                        Trip(_id: "3", name: "Road Trip", users: ["me"], startDate: "9-22-2002", endDate: "", votesToEndTrip: [])]
    
    
    var body: some View {
        TabView{
            ActivityView().tabItem({
                Image(systemName: "figure.walk")
            })
            
            
        }
    }
}

struct ActivityView: View{
    
    @State var tranactions = [
    Transaction(id: "Food", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "Beverages", userId: "me", tripId: "1", cost: 20, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "Drinks", userId: "me", tripId: "1", cost: 48.75, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "Gas", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "5", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "6", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "7", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    ]
    
    @State var trips = [
    Trip(_id: "1", name: "Punta", users: ["Me"], startDate: "", endDate: "", votesToEndTrip: [])
    ]
    var body: some View{
        GeometryReader { geo in
            ScrollView{
                HStack{
                    Text("Activity").font(.largeTitle).bold()
                    Spacer()
                    Menu(content: {
                        
                        NavigationLink("Profile", destination: {
                            //somewhere
                        })
                        
                        NavigationLink("Settings", destination: {
                            //somewhere
                        })
                    }, label: {
                        Image(systemName: "person.crop.circle").font(.largeTitle).bold()
                    })
                }.padding()
                
                ForEach($tranactions){ $transaction in
                    ActivityTransactionRow(transaction: $transaction, trips: $trips, width: geo.size.width * 0.9, height: geo.size.height * 0.15)
                }
                
                Text("You're All Caught Up")
            }.foregroundColor(Color("blue"))
        }
    }
}

struct ActivityTransactionRow: View{
    @Binding var transaction: Transaction
    @Binding var trips: [Trip]
    let width: CGFloat
    let height: CGFloat
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("gray"))
            VStack{
                HStack{
                    VStack {
                        Image(systemName: "person.crop.circle").font(.largeTitle).bold()
                        Text(transaction.userId)
                    }.padding()
                    Spacer()
                    VStack {
                        Text("$ \(transaction.cost, specifier: "%.2f")").font(.largeTitle).bold()
                        Text("\(transaction.id) for \(trips.first(where: { $0._id == transaction.tripId})?.name ?? "None")")
                    }.padding()
                }
            }
        }.frame(width: width, height: height)
    }
}

struct dataStruct: Identifiable{
    let id = UUID()
    let x: Int
    let y: Int
}

struct ShowTripsView: View{
    let trips: [Trip]
    var data = [
    dataStruct(x: 0, y: 0),
    dataStruct(x: 1, y: 1),
    dataStruct(x: 5, y: 2),
    dataStruct(x: 8, y: 47),
    dataStruct(x: 9, y: 47),
    dataStruct(x: 12, y: 48),
    dataStruct(x: 13, y: 60),
    ]
    var body: some View{
        ScrollView{
            Spacer()
            //Rectangle().foregroundColor(Color("blue")).frame(height: UIScreen.main.bounds.height - 700)
            
            HStack{
                VStack {
                    Text("Montreal").font(.system(size: 40)).bold()

                    Text("$100").font(.system(size: 40))
                    Spacer()
                    
                    Spacer()
                }
                
                Chart(data, content: { x in
                    LineMark(x: .value("", x.x), y: .value("", x.y))
                })
            }.padding().frame(width: UIScreen.main.bounds.width - 25).overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("purple"), lineWidth: 1)
            )
            
            
        }//.ignoresSafeArea()
    }
}

struct PlainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PlainHomeView()
    }
}
