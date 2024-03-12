//
//  AutomotiveSalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 26.02.24.
//

import SwiftUI
import Charts

struct AutomotiveSalesView: View {

    @StateObject var vm: MainViewModel
    @State private var selectedModel: TeslaModel = .model3Y
    @State private var selectedCarSaleState: TeslaSaleState = .produced
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
            InfoButtonSubViewNew<InfoView<TeslaModel>>(title: "Model", infoView: InfoView())
            PickerView<TeslaModel>(selection: $selectedModel)
                .pickerStyle(.palette)
            Divider()
            InfoButtonSubViewNew<InfoView<TeslaSaleState>>(title: "State", infoView: InfoView())
            PickerView<TeslaSaleState>(selection: $selectedCarSaleState)
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
        case (.otherModels, .delivered):
            yData = vm.extractData(property: .deliveredOtherModels)
        case (.otherModels, .produced):
            yData = vm.extractData(property: .producedOtherModels)
        case (.allModels, .delivered):
            yData = vm.extractData(property: .deliveredCars)
        case (.allModels, .produced):
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
