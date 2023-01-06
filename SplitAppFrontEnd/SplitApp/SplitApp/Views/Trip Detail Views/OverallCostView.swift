//
//  OverallCostView.swift
//  SplitApp
//
//  Created by John Johnston on 1/5/23.
//

import SwiftUI

struct OverallCostView: View {
    let totalCost: Double
    let howMuchYouHaveSpent: Double
    let transactions: [Transaction]
    let chartData: [Transaction]
    let trip:Trip
    var body: some View {
        ZStack(alignment: .topLeading){
            MoneySpentView(totalCost: totalCost, howMuchYouHaveSpent: howMuchYouHaveSpent, trip: trip).padding()
            ChartView(transactions: transactions, chartData: chartData).padding()
        }
    }
}
