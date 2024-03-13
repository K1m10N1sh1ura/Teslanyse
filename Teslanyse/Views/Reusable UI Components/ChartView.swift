//
//  ChartView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 13.03.24.
//

import SwiftUI
import Charts

struct ChartView: View {
    @StateObject var vm: MainViewModel
    @State private var rawSelectedDate: Date? = nil
    let xData: [Date]
    let yData: [Double]
    let numberFormat: NumberFormatType
    
    var body: some View {
        
        Chart(0..<vm.quarters.count, id: \.self) {index in
                        
            let opacity = calcBarMarkOpacity(of: index)
            
            switch SettingsClass.shared.chartStyle {
            case .barChart:
                BarMark(x: .value("Quarter", manipulateDateToQuarterMiddle(xData[index])),
                        y: .value("", yData[index]), width: barMarkWidth)
                .foregroundStyle(SettingsClass.shared.chartColor)
                .opacity(opacity)
            case .lineChart:
                LineMark(x: .value("Quarter", manipulateDateToQuarterMiddle(xData[index])),
                        y: .value("", yData[index]))
                .foregroundStyle(SettingsClass.shared.chartColor)
            case .pointChart:
                PointMark(x: .value("Quarter", manipulateDateToQuarterMiddle(xData[index])),
                        y: .value("", yData[index]))
                .foregroundStyle(SettingsClass.shared.chartColor)
                .opacity(opacity)
            }

            if let rawSelectedDate {
                BarMark(x: .value("Value", rawSelectedDate, unit: .quarter), width: 2)
                    .foregroundStyle(.secondary)
                    .zIndex(-1)
                    .annotation(position: .top,
                                spacing: 0,
                                overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopover(yData: yData)
                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
        .frame(maxHeight: 300)
        .padding(.horizontal,20)
        .padding(.bottom,20)
        .animation(.smooth, value: yData)
    }
    
    
    @ViewBuilder
    func selectionPopover(yData: [Double]) -> some View {
        if let rawSelectedDate {
            VStack {
                if let indexOfQuarter = vm.getIndexOfQuarter(rawSelectedDate.formatted(.dateTime.year().quarter())) {
                    Text(vm.quarters[indexOfQuarter].quarter)
                    Text(yData[indexOfQuarter].customNumberFormat(formatType: numberFormat))
                }
                else {
                    Text("No data")
                }
            }
            .padding(6)
            .foregroundColor(.black)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
    
    func manipulateDateToQuarterMiddle(_ date: Date) -> Date {
        // This function is essential for accurately positioning the bar mark at the midpoint between the start and end of a quarter within the chart
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: 1, to: date) {
            if let newDate = calendar.date(byAdding: .day, value: 15, to: newDate) {
                return newDate
            }
            return newDate
        }
        else {
            return Date()
        }
    }

    func calcBarMarkOpacity(of index: Int) -> Double {
                
        if let rawSelectedDate = rawSelectedDate {
            let calendar = Calendar.current
            func quarter(of date: Date) -> (year: Int, quarter: Int) {
                let components = calendar.dateComponents([.year, .month], from: date)
                let month = components.month ?? 0
                let year = components.year ?? 0
                let quarter = ((month - 1) / 3) + 1
                return (year, quarter)
            }

            let date1Quarter = quarter(of: rawSelectedDate)
            let date2Quarter = quarter(of: xData[index])
            if date1Quarter.year == date2Quarter.year && date1Quarter.quarter == date2Quarter.quarter {
                return 1.0
            }
            else {
                return 0.4
            }
        }
        else {
            return 1.0
        }
    }
}
