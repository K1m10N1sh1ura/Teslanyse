//
//  AutomotiveFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI
import Charts

struct AutomotiveFinancialsView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var selection = AutomotiveFinancialDataOption.revenue
    var subtitle: String {
        "Automotive - \(selection.description)"
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: subtitle)
            AutomotiveFinancialsChartView(plotDataViewModel: plotDataViewModel, selection: selection)
            Divider()
            InfoButtonSubView(title: "Select metric")
            PickerAutomotiveFinancialsView(selection: $selection)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AutomotiveFinancialsView(plotDataViewModel: plotDataViewModel)
    }
}


struct PickerAutomotiveFinancialsView: View {
    
    @Binding var selection: AutomotiveFinancialDataOption
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(AutomotiveFinancialDataOption.allCases, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(.wheel)
    }
}


struct AutomotiveFinancialsChartView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var rawSelectedDate: Date? = nil
    let selection: AutomotiveFinancialDataOption
    
    var body: some View {
        let xData = plotDataViewModel.extractQuarters()
        let yData: [Double]

        switch (selection) {
        case .revenue:
            yData = plotDataViewModel.extractData(property: .automotiveRevenue)
        case .costOfRevenue:
            yData = plotDataViewModel.extractData(property: .automotiveCostOfRevenue)
        case .profit:
            yData = plotDataViewModel.extractData(property: .automotiveProfit)
        case .margin:
            yData = plotDataViewModel.extractData(property: .automotiveMargin)
        case .cogs:
            yData = plotDataViewModel.extractData(property: .automotiveCostOfGoodsSold)
        }
        
        return Chart(0..<plotDataViewModel.quarters.count, id: \.self) {index in
                BarMark(x: .value("Quarter", xData[index]),
                        y: .value("$", yData[index]), width: barMarkWidth)
            if let rawSelectedDate {
                BarMark(x: .value("Value", rawSelectedDate, unit: .weekOfYear))
                    .foregroundStyle(.gray)
                    .zIndex(-1)
                    .annotation(position: .top,
                                spacing: 0,
                                overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopover()

                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func selectionPopover() -> some View {
        if let rawSelectedDate {
            VStack {
                Text(rawSelectedDate.formatted(.dateTime.year().quarter()))
                Text("$: 999.999")
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
}
