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
            if !vm.quarters.isEmpty {
                let yData = fetchChartData()
                QuarterChartView(vm: vm, yData: yData, numberFormat: .number)
            } else {
                // placeholder
            }
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
    
    private func fetchChartData() -> [Double] {
        let yData: [Double]
        
        switch selection {
        case .solarDeployed:
            yData = vm.quarters.map { Double($0.solarDeployed) }
        case .storageDeployed:
            yData = vm.quarters.map { Double($0.energyStorage) }
        }
        return yData
    }
}

#Preview {
    NavigationStack {
        EnergySalesView(vm: vmPreview)
    }
}

