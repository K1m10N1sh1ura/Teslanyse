//
//  EnergySalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI

struct EnergySalesView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @State private var selectionType: EnergyOptions = .storageDeployed
    @State private var selectionAccumulated: SelectionYesNo = .yes
    @State private var numberFormat: NumberFormatType = .power
    @State private var subtitle: String = "Storage deployed in Wh"

    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Energy Sales")
            SubtitleView(subtitle: subtitle)
            if !vm.quarters.isEmpty {
                let yData = fetchChartData()
                QuarterChartView(vm: vm, yAxislabel: numberFormat.rawValue, yData: yData, numberFormat: numberFormat)
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }
            Divider()
            InfoButtonView<InfoView<EnergyOptions>>(title: "Type", infoView: InfoView())
            PickerView<EnergyOptions>(selection: $selectionType)
                .pickerStyle(.palette)
            Text("Accumulated") 
                .font(.title2)
                .padding(.horizontal)
            PickerView<SelectionYesNo>(selection: $selectionAccumulated)
                .pickerStyle(.palette)
            Divider()
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectionType) {
            switch selectionType {
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
        
        let selection: QuarterDataEnum
        switch selectionType {
        case .solarDeployed:
            selection = selectionAccumulated == .yes ? .solarDeployedAccumulated : .solarDeployed
        case .storageDeployed:
            selection = selectionAccumulated == .yes ? .energySotrageAccumulated : .energyStorage
        }
        
        switch selection {
        case .solarDeployed:
            yData = vm.quarters.map { Double($0.solarDeployed) }
        case .energyStorage:
            yData = vm.quarters.map { Double($0.energyStorage) }
        case .solarDeployedAccumulated:
            yData = vm.quarters.map { Double($0.solarDeployedAccumulated) }
        case .energySotrageAccumulated:
            yData = vm.quarters.map { Double($0.energyStorageAccumulated) }
        default:
            yData = []
        }
        return yData
    }
}

#Preview {
    NavigationStack {
        EnergySalesView(vm: quarterDataVM)
    }
}

