//
//  InputStartAndEndDates.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct InputStartDate:View{
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var startDate: String
    @State var sDate: Date = Date.now
    
    
    var body: some View{
        VStack{
            DatePicker("Start Date", selection: $sDate, displayedComponents: .date).datePickerStyle(.graphical).padding().onChange(of: sDate, perform: { _ in
                startDate = envVar.dateToStr(date: sDate)
            })
        }.padding()
    }
    
    
}
