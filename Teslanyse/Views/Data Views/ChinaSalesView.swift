//
//  ChinaSalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 14.03.24.
//

import SwiftUI
import Charts

struct ChinaSalesView: View {
    
    @StateObject var vm: WeekDataViewModel
    @State var selection: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "China")
            SubtitleView(subtitle: "Weekly Sales")
            ScrollView (.horizontal) {
                if vm.dataLoaded {
                    let yData = vm.weeks.map { Double($0.units) }
                    WeekChartView(vm: vm, yData: yData, numberFormat: .number)
                        .frame(width: 1000, height: 500)
                } else {
                    Text("No Data")
                }
            }
            Picker("", selection: $selection) {
                Text("Q1")
                Text("Q2")
                Text("Q3")
                Text("Q4")
            }
            .pickerStyle(.palette)
            .padding()
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChinaSalesView(vm: weekDataVM)
}
