//
//  SuperchargerView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 01.03.24.
//

import SwiftUI

struct SuperchargerView: View {
    
    @StateObject var vm: MainViewModel
    @State private var selectionType: SuperchargerInfrastructure = .stations
    @State private var selectionAccumulated: SelectionYesNo = .yes
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Supercharger")
            SubtitleView(subtitle: selectionType.description)
            if !vm.quarters.isEmpty {
                let (xData, yData) = fetchChartData()
                ChartView(vm: vm, xData: xData, yData: yData, numberFormat: .number)
            } else {
                // placeholder
            }
            Divider()
            InfoButtonView<InfoView<SuperchargerInfrastructure>>(title: "Type", infoView: InfoView())
            PickerView<SuperchargerInfrastructure>(selection: $selectionType)
                .pickerStyle(.palette)
            Divider()
            Text("Accumulated") // Explicitly add the label here
                .font(.headline)
                .padding(.horizontal)            
            PickerView<SelectionYesNo>(selection: $selectionAccumulated)
                .pickerStyle(.palette)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchChartData() -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]
        
        switch selectionType {
        case .stations:
            let selection: QuarterDataEnum = selectionAccumulated == .yes ? .superchargerStationsAccumulated : .superchargerStations
            yData = vm.extractData(property: selection)
        case .connectors:
            let selection: QuarterDataEnum = selectionAccumulated == .yes ? .superchargerConnectorsAccumulated : .superchargerConnectors
            yData = vm.extractData(property: selection)
        }
        return (xData, yData)
    }
}

#Preview {
    NavigationStack {
        SuperchargerView(vm: vmPreview)
    }
}

