//
//  ChinaSalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 14.03.24.
//

import SwiftUI
import Charts

struct ChinaSalesView: View {
    
    @StateObject var vm: ChinaSalesViewModel

    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "China")
            SubtitleView(subtitle: "Weekly Sales")
            ScrollView (.horizontal) {
                if !vm.weeks.isEmpty {
                    let (xData, yData) = fetchChartData()
                    Chart(0..<vm.weeks.count, id: \.self) {index in
                                                        
                        switch SettingsClass.chartStyle {
                        case .barChart:
                            BarMark(x: .value("Quarter", xData[index]),
                                    y: .value("", yData[index]), width: barMarkWidth)
                            .foregroundStyle(SettingsClass.chartColor)
                        case .lineChart:
                            LineMark(x: .value("Quarter", xData[index]),
                                    y: .value("", yData[index]))
                            .foregroundStyle(SettingsClass.chartColor)
                        case .pointChart:
                            PointMark(x: .value("Quarter", xData[index]),
                                    y: .value("", yData[index]))
                            .foregroundStyle(SettingsClass.chartColor)
                        }
                    }
                    .frame(width: 1000)
                    .padding()
                } else {
                    Text("No Data")
                }
            }
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchChartData() -> ([Date],[Int]) {
        let xData = vm.extractWeeks()
        let yData: [Int]

        yData = vm.weeks.map { $0.units }

        return (xData, yData)
    }
}

#Preview {
    ChinaSalesView(vm: vmChinaSalesPreview)
}
