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
    @State private var selectionAccumulated: SelectionYesNo = .no
    private var subtitle: String {
        "\(selectedModel.description) - \(selectedCarSaleState.description)"
    }

    var body: some View {
        VStack(alignment: .leading) {
            TitleView(title: "Automotive Sales")
            SubtitleView(subtitle: subtitle)
            if !vm.quarters.isEmpty {
                let (xData, yData) = fetchChartData()
                ChartView(vm: vm, xData: xData, yData: yData, numberFormat: .number)
            } else {
                // placeholder
            }
            Divider()
            InfoButtonView<InfoView<TeslaVehicleModel>>(title: "Model", infoView: InfoView())
            PickerView<TeslaVehicleModel>(selection: $selectedModel)
                .pickerStyle(.palette)
            Divider()
            InfoButtonView<InfoView<VehicleSaleState>>(title: "State", infoView: InfoView())
            PickerView<VehicleSaleState>(selection: $selectedCarSaleState)
                .pickerStyle(.palette)
            Divider()
            Text("Accumulated")
                .font(.headline)
                .padding(.horizontal)
            PickerView<SelectionYesNo>(selection: $selectionAccumulated)
                .pickerStyle(.palette)
            Divider()
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchChartData() -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]
        
        switch (selectedModel, selectedCarSaleState, selectionAccumulated) {
        case (.model3Y, .delivered, .no):
            yData = vm.extractData(property: .deliveredModel3Y)
        case (.model3Y, .produced, .no):
            yData = vm.extractData(property: .producedModel3Y)
        case (.other, .delivered, .no):
            yData = vm.extractData(property: .deliveredOtherModels)
        case (.other, .produced, .no):
            yData = vm.extractData(property: .producedOtherModels)
        case (.all, .delivered, .no):
            yData = vm.extractData(property: .deliveredCars)
        case (.all, .produced, .no):
            yData = vm.extractData(property: .producedCars)
        case (.model3Y, .delivered, .yes):
            yData = vm.extractData(property: .deliveredModel3YAccumulated)
        case (.model3Y, .produced, .yes):
            yData = vm.extractData(property: .producedModel3YAccumulated)
        case (.other, .delivered, .yes):
            yData = vm.extractData(property: .deliveredOtherModelsAccumulated)
        case (.other, .produced, .yes):
            yData = vm.extractData(property: .producedOtherModelsAccumulated)
        case (.all, .delivered, .yes):
            yData = vm.extractData(property: .deliveredCarsAccumulated)
        case (.all, .produced, .yes):
            yData = vm.extractData(property: .producedCarsAccumulated)
        }
        return (xData, yData)
    }

}



#Preview {
    NavigationStack {
        AutomotiveSalesView(vm: vmPreview)
    }
}
