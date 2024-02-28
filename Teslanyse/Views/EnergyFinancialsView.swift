//
//  EnergyFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI
import Charts

struct EnergyFinancialsView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    var subtitle: String {
        "Storage in Wh"
    }
    
    var body: some View {
        VStack {
            TitleView(title: "Energy Finacials")
            SubtitleView(subtitle: subtitle)
            Chart(plotDataViewModel.quarters) { quarter in
                BarMark(x: .value("", quarter.date),
                        y: .value("", quarter.energyStorage))
            }

        }
    }
}

#Preview {
    NavigationStack {
        EnergyFinancialsView(plotDataViewModel: plotDataViewModel)

    }
}
