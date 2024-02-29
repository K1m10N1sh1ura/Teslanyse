//
//  EnergySalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI
import Charts

struct EnergySalesView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    
    var body: some View {
        VStack {
            TitleView(title: "Energy Sales")
            SubtitleView(subtitle: "Storage in Wh")
            Chart(plotDataViewModel.quarters) { quarter in
                BarMark(x: .value("", quarter.date),
                        y: .value("", quarter.energyStorage))
            }

        }
    }
}

#Preview {
    NavigationStack {
        EnergySalesView(plotDataViewModel: plotDataViewModel)
    }
}