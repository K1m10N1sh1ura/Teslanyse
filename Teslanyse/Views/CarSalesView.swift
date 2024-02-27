//
//  CarSalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 26.02.24.
//

import SwiftUI
import Charts

struct CarSalesView: View {

    @StateObject var plotDataViewModel = PlotDataViewModel()
    @State var selectedModel = TeslaModel.model3Y
    @State var selectedCarSaleState = TeslaSaleState.produced


    var body: some View {
        VStack(alignment: .leading) {
            TitleView(model: selectedModel.description, saleState: selectedCarSaleState.description)
            ChartView(plotDataViewModel: plotDataViewModel, model: selectedModel, saleState: selectedCarSaleState)
                .animation(.smooth)
            Divider()
            Picker("Select a Tesla Model", selection: $selectedModel) {
                ForEach(TeslaModel.allCases, id: \.self) { model in
                    Text(model.description)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            Divider()
            Picker("Select sale state", selection: $selectedCarSaleState) {
                ForEach(TeslaSaleState.allCases, id: \.self) { saleState in
                    Text(saleState.description)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            ExportButtonView()
        }
    }

}



#Preview {
    CarSalesView()
}

struct TitleView: View {
    let model: String
    let saleState: String
    var body: some View {
        Text("Car Sales")
            .multilineTextAlignment(.leading)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 20)
            .padding(.leading, 20)
        Text(model + " - " + saleState)
            .multilineTextAlignment(.leading)
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.leading, 20)
    }
}

struct CarToggleView: View {
    
    let toggleText: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(toggleText, isOn: $isOn)
            .toggleStyle(.button)
    }
}

struct ChartView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    let model: TeslaModel
    let saleState: TeslaSaleState
    let yAxisLabel: String = "Cars"

    var body: some View {

        Chart(plotDataViewModel.quarters) {quarterData in
            
            switch (model) {
            case .model3Y:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, saleState == .delivered ? quarterData.deliveredModel3Y : quarterData.producedModel3Y)
                )
            case .otherModels:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, saleState == .delivered ? quarterData.deliveredOtherModels : quarterData.producedOtherModels)
                )
            case .allModels:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, saleState == .delivered ? quarterData.deliveredCars : quarterData.producedCars)
                )
            }
        }
        .frame(maxHeight: 300)
        .padding(.horizontal,20)
        .padding(.bottom,20)
    }
}

struct ExportButtonView: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Export Chart")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10.0)
                .padding()
        })
    }
}
