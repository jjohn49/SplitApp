//
//  InputTripSettings.swift
//  SplitApp
//
//  Created by John Johnston on 1/27/23.
//

import SwiftUI

struct InputTripSettings: View {
    @State var test: Bool = false
    var body: some View {
        List{
            SettingRow(settingTitle: (test ? "Private" :  "Public") , settingToggle: $test)
        }.cornerRadius(10)
    }
}

struct SettingRow: View{
    let settingTitle: String
    @Binding var settingToggle: Bool
    var body: some View{
        HStack{
            
            Toggle(isOn: $settingToggle, label: {
                Text(settingTitle)
            })
        }
    }
}

struct InputTripSettings_Previews: PreviewProvider {
    static var previews: some View {
        InputTripSettings()
    }
}
