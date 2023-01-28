//
//  InputStartAndEndDates.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct InputStartAndEdDates:View{
    @EnvironmentObject var envVar: EnviormentVariables
    @Binding var startDate: String
    @Binding var endDate: String
    @State var sDate: Date = Date.now
    @State var eDate: Date = Date.now
    
    var body: some View{
        HStack(alignment: .center){
        
            DatePicker("", selection: $sDate, displayedComponents: .date).datePickerStyle(.compact).padding().onChange(of: sDate, perform: { _ in
                startDate = envVar.dateToStr(date: sDate)
            })
            Text("to").padding()
            
            DatePicker("", selection: $eDate, displayedComponents: .date).datePickerStyle(.compact).padding().onChange(of: eDate, perform: { _ in
                endDate = envVar.dateToStr(date: eDate)
            })
        }
    }
    
    
}
