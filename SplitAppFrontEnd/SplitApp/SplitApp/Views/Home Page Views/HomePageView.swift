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







struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}



