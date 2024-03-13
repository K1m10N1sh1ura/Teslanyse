//
//  EnergySalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI

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
            InfoButtonView<InfoView<EnergyOptions>>(title: "Type", infoView: InfoView())
            PickerView<EnergyOptions>(selection: $selection)
                .pickerStyle(.palette)
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

