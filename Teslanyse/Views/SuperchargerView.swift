//
//  SuperchargerView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 01.03.24.
//

import SwiftUI
import Charts

struct SuperchargerView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var selection: SuperchargerOption = .stations
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Supercharger")
            SubtitleView(subtitle: selection.desciption)
            SuperchargerChartView(plotDataViewModel: plotDataViewModel, selection: selection)
            Picker("", selection: $selection) {
                ForEach(SuperchargerOption.allCases, id: \.self) {
                    Text($0.desciption)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SuperchargerView(plotDataViewModel: plotDataViewModel)
    }
}

struct SuperchargerChartView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    let selection: SuperchargerOption
    var countBarMarks: Int {
        plotDataViewModel.quarters.count
    }
    
    
    var body: some View {

        let xData = plotDataViewModel.extractQuarters()
        let yData: [Double]
        
        switch selection {
        case .stations:
            yData = plotDataViewModel.extractData(property: .superchargerStationsAccumulated)
        case .connectors:
            yData = plotDataViewModel.extractData(property: .superchargerConnectorsAccumulated)
        }
        
        return Chart(0..<countBarMarks, id: \.self) {index in
            BarMark(x: .value("Quarter", xData[index]),
                    y: .value(selection.desciption, yData[index]), width: barMarkWidth)
        }
        .padding(.horizontal)
    }
}
