//
//  EnergySalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI
import Charts

struct EnergySalesView: View {
    
    @StateObject var vm: MainViewModel
    @State private var selection: EnergyOptions = .storageDeployed
    @State private var numberFormat: NumberFormatType = .power
    @State private var subtitle: String = "Storage deployed in Wh"

    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Energy Sales")
            SubtitleView(subtitle: subtitle)
            let (xData, yData) = fetchChartData()
            ChartView(vm: vm, xData: xData, yData: yData, numberFormat: numberFormat)
            Divider()
            InfoButtonSubView(title: "Type")
            EnergySalesPickerView(selection: $selection)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selection) {
            switch selection {
            case .solarDeployed:
                numberFormat = .energy
                subtitle = "Solar deployed in Watt"
            case .storageDeployed:
                numberFormat = .power
                subtitle = "Storage deployed in Wh"
            }
        }
    }
    
    private func fetchChartData() -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]
        
        switch selection {
        case .solarDeployed:
            yData = vm.extractData(property: .solarDeployed)
        case .storageDeployed:
            yData = vm.extractData(property: .energyStorage)
        }
        return (xData, yData)
    }
}

#Preview {
    NavigationStack {
        EnergySalesView(vm: vmPreview)
    }
}

struct EnergySalesPickerView: View {
    @Binding var selection: EnergyOptions
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(EnergyOptions.allCases, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(.palette)
        .padding()
    }
}
