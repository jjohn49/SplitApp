//
//  PlainHomeView.swift
//  SplitApp
//
//  Created by John Johnston on 1/31/23.
//

import SwiftUI

struct PlainHomeView: View {
    var trips:[Trip] = [Trip(_id: "1", name: "1", users: ["me"], startDate: "9-22-2002", endDate: "", votesToEndTrip: []),
                        Trip(_id: "2", name: "2", users: ["me"], startDate: "9-22-2002", endDate: "", votesToEndTrip: []),
                        Trip(_id: "3", name: "3", users: ["me"], startDate: "9-22-2002", endDate: "", votesToEndTrip: [])]
    var body: some View {
        TabView{
            TopBar(trips: trips).tabItem({
                Image(systemName: "figure.walk")
            })
            
            
        }
    }
}

struct TopBar: View{
    let trips: [Trip]
    var body: some View{
        NavigationView{
            VStack(spacing: 0){
                Rectangle().foregroundColor(Color("blue")).ignoresSafeArea().frame(height: UIScreen.main.bounds.height - 800)
                
                ScrollView{
                    ForEach(trips) { trip in
                        Text(trip.name)
                    }
                }.frame(height: UIScreen.main.bounds.height - 250 /*sets the height proportionally to the devicve*/)
                
            }.navigationTitle("Activity")
        }
    }
}

struct PlainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PlainHomeView()
    }
}
