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
    @State var selection: EnergyOptions = .storageDeployed
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Energy Sales")
            SubtitleView(subtitle: "Storage in MWh")
            Chart(plotDataViewModel.quarters) { quarter in
                BarMark(x: .value("", quarter.date),
                        y: .value("", quarter.energyStorage))
            }
            .padding(.horizontal)
            Picker("", selection: $selection) {
                ForEach(EnergyOptions.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(.palette)
            .padding()
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EnergySalesView(plotDataViewModel: plotDataViewModel)
    }
}
