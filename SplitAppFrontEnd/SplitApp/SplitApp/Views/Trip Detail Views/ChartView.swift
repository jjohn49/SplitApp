//
//  ChartView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI
import Charts

//https://www.appcoda.com/swiftui-line-charts/
struct ChartView:View{
    @EnvironmentObject var envVar: EnviormentVariables
    let transactions: [Transaction]
    let chartData: [Transaction]
    @State var cost: [Int] = [0]
    var body: some View{
        ZStack {
            Chart{
                ForEach(chartData){
                    LineMark(x: .value("Date", envVar.strToDate(strDate: $0.date)), y: .value("Cost", $0.cost)).foregroundStyle(by: .value("User", $0.userId)).symbol(by: .value("User", $0.userId))
                }
                
            }.frame(width: 375, height: 200)
        }
    }
    
}
