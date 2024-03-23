//
//  SuperchargerView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 01.03.24.
//

import SwiftUI

struct SuperchargerView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @State private var selectionType: SuperchargerInfrastructure = .stations
    @State private var selectionAccumulated: SelectionYesNo = .yes
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Supercharger")
            SubtitleView(subtitle: selectionType.description)
            if !vm.quarters.isEmpty {
                let yData = fetchChartData()
                QuarterChartView(vm: vm, yAxislabel: selectionType.description, yData: yData, numberFormat: .number)
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }            }
            Divider()
            InfoButtonView<InfoView<SuperchargerInfrastructure>>(title: "Type", infoView: InfoView())
            PickerView<SuperchargerInfrastructure>(selection: $selectionType)
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
    }
    
    private func fetchChartData() -> [Double] {
        let yData: [Double]
        let selection: QuarterDataEnum
        switch selectionType {
        case .stations:
            selection = selectionAccumulated == .yes ? .superchargerStationsAccumulated : .superchargerStations
        case .connectors:
            selection = selectionAccumulated == .yes ? .superchargerConnectorsAccumulated : .superchargerConnectors
        }
        
        switch selection {
        case .superchargerStations:
            yData = vm.quarters.map { Double($0.superchargerStations) }
        case .superchargerConnectors:
            yData = vm.quarters.map { Double($0.superchargerConnectors) }
        case .superchargerStationsAccumulated:
            yData = vm.quarters.map { Double($0.superchargerStationsAccumulated) }
        case .superchargerConnectorsAccumulated:
            yData = vm.quarters.map { Double($0.superchargerConnectorsAccumulated) }
        default:
            yData = []
        }
        return yData
    }
}

#Preview {
    NavigationStack {
        SuperchargerView(vm: quarterDataVM)
    }
}

