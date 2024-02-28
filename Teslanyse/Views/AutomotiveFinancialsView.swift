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
            CarSalesSubView(title: "Select metric")
            PickerAutomotiveFinancialsView(selection: $selection)
            ExportButtonView()
        }
        
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
    let yAxisLabel: String = "$"

    var body: some View {
        
        Chart(plotDataViewModel.quarters) {quarterData in

            switch (selection) {
            case .revenue:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, quarterData.carRevenue))
            case .profit:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, quarterData.automotiveProfit))
            case .cogs:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, quarterData.automotiveCostOfGoodsSold))
            case .margin:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, quarterData.automotiveMargin))
            case .costOfRevenue:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, quarterData.carCostOfRevenue))
            }
            
            if let rawSelectedDate {
                BarMark(x: .value("Value", rawSelectedDate, unit: .weekOfYear))
                    .foregroundStyle(.gray)
                    .zIndex(-1)
                    .annotation(position: .top,
                                spacing: 0,
                                overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopover(quarterData: quarterData)
                }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
        .frame(maxHeight: 300)
        .padding(.horizontal,20)
        .padding(.bottom,20)
    }
    
    @ViewBuilder
    func selectionPopover(quarterData: QuarterData) -> some View {
        if let rawSelectedDate {
            VStack {
                Text(rawSelectedDate.formatted(.dateTime.year().quarter()))
                Text("$999999")
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
