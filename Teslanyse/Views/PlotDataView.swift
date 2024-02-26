//
//  PlotDataView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import SwiftUI
import Charts

struct PlotDataView: View {
    
    @StateObject var plotDataViewModel = PlotDataViewModel()

    var body: some View {
            Chart(plotDataViewModel.quarters) {quarterData in
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value("Revenue", quarterData.revenue))
                //.foregroundStyle(.blue)
            }
            .padding()
            .navigationTitle("Revenue")
    }
}

#Preview {
    PlotDataView()
}
