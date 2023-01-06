//
//  TripsView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct TripsView: View {
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

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}
