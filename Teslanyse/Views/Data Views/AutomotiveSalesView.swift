//
//  AutomotiveSalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 26.02.24.
//

import SwiftUI

struct AutomotiveSalesView: View {

    @StateObject var vm: MainViewModel
    @State private var selectedModel: TeslaVehicleModel = .model3Y
    @State private var selectedCarSaleState: VehicleSaleState = .produced
    private var subtitle: String {
        "\(selectedModel.description) - \(selectedCarSaleState.description)"
    }

    var body: some View {
        VStack(alignment: .leading) {
            TitleView(title: "Automotive Sales")
            SubtitleView(subtitle: subtitle)
            let (xData, yData) = fetchChartData()
            ChartView(vm: vm, xData: xData, yData: yData, numberFormat: .number)
            Divider()
            InfoButtonView<InfoView<TeslaVehicleModel>>(title: "Model", infoView: InfoView())
            PickerView<TeslaVehicleModel>(selection: $selectedModel)
                .pickerStyle(.palette)
            Divider()
            InfoButtonView<InfoView<VehicleSaleState>>(title: "State", infoView: InfoView())
            PickerView<VehicleSaleState>(selection: $selectedCarSaleState)
                .pickerStyle(.palette)
            Divider()
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchChartData() -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]
        
        switch (selectedModel, selectedCarSaleState) {
        case (.model3Y, .delivered):
            yData = vm.extractData(property: .deliveredModel3Y)
        case (.model3Y, .produced):
            yData = vm.extractData(property: .producedModel3Y)
        case (.other, .delivered):
            yData = vm.extractData(property: .deliveredOtherModels)
        case (.other, .produced):
            yData = vm.extractData(property: .producedOtherModels)
        case (.all, .delivered):
            yData = vm.extractData(property: .deliveredCars)
        case (.all, .produced):
            yData = vm.extractData(property: .producedCars)
        }
        return (xData, yData)
    }

}



#Preview {
    NavigationStack {
        AutomotiveSalesView(vm: vmPreview)
    }
}
