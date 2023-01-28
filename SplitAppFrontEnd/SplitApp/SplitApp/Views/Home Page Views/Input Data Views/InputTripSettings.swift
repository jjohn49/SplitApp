//
//  InputTripSettings.swift
//  SplitApp
//
//  Created by John Johnston on 1/27/23.
//

import SwiftUI

struct InputTripSettings: View {
    @State var isPrivate: Bool = false
    @State var isNotificationsOn: Bool = false
    var body: some View {
        Form{
            Section("", content: {
                SettingRow(settingTitle: (isPrivate ? "Private": "Public"), settingToggle: $isPrivate)
            })
        }.frame(height: 500).cornerRadius(10).padding()
        
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
