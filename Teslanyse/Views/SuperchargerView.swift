//
//  SuperchargerView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 01.03.24.
//

import SwiftUI
import Charts

struct SuperchargerView: View {
    
    @StateObject var vm: MainViewModel
    @State private var selection: SuperchargerOption = .stations

    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Supercharger")
            SubtitleView(subtitle: selection.desciption + " accumulated")
            let (xData, yData) = userSelection()
            ChartView(vm: vm, xData: xData, yData: yData, numberFormat: .number)
            Divider()
            InfoButtonSubView(title: "Type")
            SuperchargerPickerView(selection: $selection)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func userSelection() -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]
        
        switch selection {
        case .stations:
            yData = vm.extractData(property: .superchargerStationsAccumulated)
        case .connectors:
            yData = vm.extractData(property: .superchargerConnectorsAccumulated)
        }
        
        return (xData, yData)
    }
}

#Preview {
    NavigationStack {
        SuperchargerView(vm: vm)
    }
}

struct SuperchargerPickerView: View {
    @Binding var selection: SuperchargerOption
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(SuperchargerOption.allCases, id: \.self) {
                Text($0.desciption)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
}
