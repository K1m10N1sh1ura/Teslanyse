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
            EnergySalesChartView(plotDataViewModel: plotDataViewModel, selection: selection)
            Divider()
            InfoButtonSubView(title: "Type")
            Picker("", selection: $selection) {
                ForEach(EnergyOptions.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(.palette)
            .padding()
            ExportButtonView(chart: Text("Test"))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EnergySalesChartView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    let selection: EnergyOptions
    var countBarMarks: Int {
        plotDataViewModel.quarters.count
    }
    
    
    var body: some View {

        let xData = plotDataViewModel.extractQuarters()
        let yData: [Double]
        
        switch selection {
        case .solarDeployed:
            yData = plotDataViewModel.extractData(property: .solarDeployed)
        case .storageDeployed:
            yData = plotDataViewModel.extractData(property: .energyStorage)
        }
        
        return Chart(0..<countBarMarks, id: \.self) {index in
            BarMark(x: .value("Quarter", xData[index]),
                    y: .value(selection.description, yData[index]), width: barMarkWidth)
        }
        .padding(.horizontal)
    }
}


#Preview {
    NavigationStack {
        EnergySalesView(plotDataViewModel: plotDataViewModel)
    }
}
