//
//  PlainHomeView.swift
//  SplitApp
//
//  Created by John Johnston on 1/31/23.
//

import SwiftUI
import Charts

struct PlainHomeView: View {
    
    var body: some View {
        Text("Hello")
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
