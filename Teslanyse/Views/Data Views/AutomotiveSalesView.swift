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
                let yData = fetchChartData()
                QuarterChartView(vm: vm, yData: yData, numberFormat: .number)
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
    
    private func fetchChartData() -> [Double] {
        let yData: [Double]
        
        switch (selectedModel, selectedCarSaleState, selectionAccumulated) {
        case (.model3Y, .delivered, .no):
            yData = vm.quarters.map { Double($0.deliveredModel3Y) }
        case (.model3Y, .produced, .no):
            yData = vm.quarters.map { Double($0.producedModel3Y) }
        case (.other, .delivered, .no):
            yData = vm.quarters.map { Double($0.deliveredOtherModels) }
        case (.other, .produced, .no):
            yData = vm.quarters.map { Double($0.producedOtherModels) }
        case (.all, .delivered, .no):
            yData = vm.quarters.map { Double($0.deliveredCars) }
        case (.all, .produced, .no):
            yData = vm.quarters.map { Double($0.producedCars) }
        case (.model3Y, .delivered, .yes):
            yData = vm.quarters.map { Double($0.deliveredModel3YAccumulated) }
        case (.model3Y, .produced, .yes):
            yData = vm.quarters.map { Double($0.producedModel3YAccumulated) }
        case (.other, .delivered, .yes):
            yData = vm.quarters.map { Double($0.deliveredOtherModelsAccumulated) }
        case (.other, .produced, .yes):
            yData = vm.quarters.map { Double($0.producedOtherModelsAccumulated) }
        case (.all, .delivered, .yes):
            yData = vm.quarters.map { Double($0.deliveredCarsAccumulated) }
        case (.all, .produced, .yes):
            yData = vm.quarters.map { Double($0.producedCarsAccumulated) }
        }
        return yData
    }

}



#Preview {
    NavigationStack {
        AutomotiveSalesView(vm: vmPreview)
    }
}
