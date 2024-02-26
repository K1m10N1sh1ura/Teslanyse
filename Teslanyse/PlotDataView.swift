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
        ScrollView {
            Chart {
                ForEach(plotDataViewModel.quarters) {quarter in
                    BarMark(x: .value("Quarter", quarter.quarter),
                            y: .value("Revenue", quarter.revenue))
                    .foregroundStyle(.blue)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }
        .padding()
    }
}

#Preview {
    PlotDataView()
}
