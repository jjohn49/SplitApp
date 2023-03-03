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
            ActivityView().tabItem({
                Image(systemName: "figure.walk")
            })
        }.onAppear(perform: {
            Task{
                envVars.getAllTripsForUser()
                envVars.allTransactions =  try await envVars.getAllTransactionsForTripsWithUser()
            }
            
        }).environmentObject(envVars)
    }
}

/*
struct temp: View {
    
    var body: some View {
        /*TabView{
            .tabItem{
                Label("", systemImage: "airplane").font(.title2)
            }
        }.environmentObject(envVars).onAppear(perform: envVars.getAllTripsForUser) */
        
        TripsView().environmentObject(envVars).onAppear(perform: envVars.getAllTripsForUser)
    }
}*/







