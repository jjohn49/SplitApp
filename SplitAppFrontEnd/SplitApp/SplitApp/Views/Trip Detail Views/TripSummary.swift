//
//  TripSummary.swift
//  SplitApp
//
//  Created by John Johnston on 1/26/23.
//

import SwiftUI

struct TripSummary: View {
    var body: some View {
        ScrollView {
            Text("What Happens in Vegas... You Get The Rest ").bold().font(.largeTitle).padding()
            
            //ChartView()
        }
    }
}

struct TripSummary_Previews: PreviewProvider {
    static var previews: some View {
        TripSummary()
    }
}
