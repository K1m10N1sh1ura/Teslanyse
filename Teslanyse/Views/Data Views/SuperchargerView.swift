//
//  SuperchargerView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 01.03.24.
//

import SwiftUI

struct SuperchargerView: View {
    
    @StateObject var vm: MainViewModel
    @State private var selectionType = "Stations"
    @State private var selectionAccumulated = "No"
    @State var selection: SuperchargerInfrastructure = .stations
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Supercharger")
            SubtitleView(subtitle: selection.description)
            if !vm.quarters.isEmpty {
                let (xData, yData) = fetchChartData()
                ChartView(vm: vm, xData: xData, yData: yData, numberFormat: .number)
            } else {
                // placeholder
            }
            Divider()
            InfoButtonView<InfoView<SuperchargerInfrastructure>>(title: "Type", infoView: InfoView())
            Picker("", selection: $selectionType) {
                Text("Stations")
                    .tag("Stations")
                Text("Connectors")
                    .tag("Connectors")
            }
            .pickerStyle(.palette)
            .padding(.horizontal)
            InfoButtonView<InfoView<SuperchargerInfrastructure>>(title: "Accumulated", infoView: InfoView())
            Picker("", selection: $selectionAccumulated) {
                Text("No")
                    .tag("No")
                Text("Yes")
                    .tag("Yes")
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectionType) {
            chartSelection()
        }
        .onChange(of: selectionAccumulated) {
            chartSelection()
        }
    }
    
    private func chartSelection() {
        switch selectionType {
        case "Connectors":
            selection = selectionAccumulated == "Yes" ? .connectorsAccumulated : .connectors
        case "Stations":
            selection = selectionAccumulated == "Yes" ? .stationsAccumulated : .stations
        default:
            selection = .connectors
        }
    }
    private func fetchChartData() -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]
        
        switch selection {
        case .stations:
            yData = vm.extractData(property: .superchargerStations)
        case .connectors:
            yData = vm.extractData(property: .superchargerConnectors)
        case .stationsAccumulated:
            yData = vm.extractData(property: .superchargerStationsAccumulated)
        case .connectorsAccumulated:
            yData = vm.extractData(property: .superchargerConnectorsAccumulated)

        }
        
        return (xData, yData)
    }
}

#Preview {
    NavigationStack {
        SuperchargerView(vm: vmPreview)
    }
}

