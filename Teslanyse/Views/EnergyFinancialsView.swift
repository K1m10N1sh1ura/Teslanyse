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
    @State var selection: EnergyFinancialDataOption = .revenue
    var subtitle: String {
        "Energy - \(selection.description)"
    }
    let yAxisLabel: String = "$"
    var countBarMarks: Int {
        plotDataViewModel.quarters.count
    }
    
    
    var body: some View {

        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: subtitle)
            EnergyFinancialsChartView(plotDataViewModel: plotDataViewModel, selection: selection)
            EnergyFinancialsPickerView(selection: $selection)
            ExportButtonView(chart: Text("Test"))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EnergyFinancialsView(plotDataViewModel: plotDataViewModel)
    }
}

struct EnergyFinancialsPickerView: View {
    @Binding var selection: EnergyFinancialDataOption
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(EnergyFinancialDataOption.allCases, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(.wheel)
    }
}

struct EnergyFinancialsChartView: View {
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var rawSelectedDate: Date? = nil
    @Environment (\.calendar) var calendar
    let selection: EnergyFinancialDataOption
    let yAxisLabel: String = "$"
    var countBarMarks: Int {
        plotDataViewModel.quarters.count
    }
    var selectedDateValue: Int? {
        if let rawSelectedDate {
            let quarter = plotDataViewModel.quarters.first {
                let startOfQuarter = $0.date
                let endOfQuarter = calendar.date(byAdding: .quarter, value: 1, to: startOfQuarter) ?? Date()
                return (startOfQuarter...endOfQuarter).contains(rawSelectedDate)
            }
            return nil
        }
        else {
            return nil
        }
    }
    
    
    var body: some View {
        let xData = plotDataViewModel.extractQuarters()
        let yData: [Double]

        switch (selection) {
        case .revenue:
            yData = plotDataViewModel.extractData(property: .energyRevenue)
        case .costOfRevenue:
            yData = plotDataViewModel.extractData(property: .energyCostOfRevenue)
        case .profit:
            yData = plotDataViewModel.extractData(property: .energyProfit)
        case .margin:
            yData = plotDataViewModel.extractData(property: .energyMargin)
        case .cogs:
            yData = plotDataViewModel.extractData(property: .energyCostOfGoodsSold)
        }
        
        return Chart(0..<countBarMarks, id: \.self) {index in
                BarMark(x: .value("Quarter", xData[index]),
                        y: .value(yAxisLabel, yData[index]), width: barMarkWidth)
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
        .frame(maxHeight: 300)
        .padding(.horizontal,20)
        .padding(.bottom,20)
    }
    
    @ViewBuilder
    func selectionPopover() -> some View {
        if let rawSelectedDate {
            VStack {
                Text(rawSelectedDate.formatted(.dateTime.year().quarter()))
                Text("")
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
