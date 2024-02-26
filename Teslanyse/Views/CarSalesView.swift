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
    @State var carModelToShowIndex = 0
    @State var carSaleStateToShowIndex = 0
    let carModelToShowOptions = ["Model 3/Y","Model S/X","Total"]
    let carSaleStateToShowOptions = ["Delivered","Produced"]

    var body: some View {
        VStack(alignment: .leading) {
            TitleView(model: carModelToShowOptions[carModelToShowIndex], saleState: carSaleStateToShowOptions[carSaleStateToShowIndex])
            ChartView(plotDataViewModel: plotDataViewModel, modelIndex: carModelToShowIndex, saleStateIndex: carSaleStateToShowIndex)
            Divider()
            Picker("", selection: $carModelToShowIndex) {
                ForEach(carModelToShowOptions.indices, id: \.self) {
                    Text(self.carModelToShowOptions[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            Divider()
            Picker("", selection: $carSaleStateToShowIndex) {
                ForEach(carSaleStateToShowOptions.indices, id: \.self) {
                    Text(self.carSaleStateToShowOptions[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            Spacer()
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
    
    let modelIndex: Int
    let saleStateIndex: Int
    
    var body: some View {
        
        Chart(plotDataViewModel.quarters) {quarterData in
            
            switch (modelIndex) {
            case 0:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value("Revenue", saleStateIndex == 0 ? quarterData.deliveredModel3Y : quarterData.producedModel3Y)
                )
            case 1:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value("Revenue", saleStateIndex == 0 ? quarterData.deliveredOtherModels : quarterData.producedOtherModels)
                )
            case 2:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value("Revenue", saleStateIndex == 0 ? quarterData.deliveredCars : quarterData.producedCars)
                )
            default:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value("Revenue", quarterData.deliveredModel3Y)
                )
            }

        }
        .frame(maxHeight: 400)
        .padding(.horizontal,20)
        .padding(.bottom,20)
    }
}
