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
            ActivityView()
            //ShowTripsView(trips: trips).tabItem({
                //Image(systemName: "figure.walk")
            //})
            
            
        }
    }
}

struct ActivityView: View{
    
    var tranactions = [
    Transaction(id: "1", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "2", userId: "me", tripId: "1", cost: 20, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "3", userId: "me", tripId: "1", cost: 48.75, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "4", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "5", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "6", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    Transaction(id: "7", userId: "me", tripId: "1", cost: 100, date: "1-1-2000", votesToDelete: []),
    ]
    var body: some View{
        ScrollView{
            HStack{
                Text("Activity View").font(.largeTitle).bold()
                Spacer()
            }.padding()
            
            ForEach(tranactions){ transaction in
                VStack{
                    HStack{
                        Text("$\(transaction.cost)")
                    }
                }
            }
        }
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
