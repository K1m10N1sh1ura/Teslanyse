//
//  AutomotiveSalesView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 26.02.24.
//

import SwiftUI
import Charts

struct AutomotiveSalesView: View {

    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var selectedModel: TeslaModel = .model3Y
    @State var selectedCarSaleState: TeslaSaleState = .produced
    var subtitle: String {
        "\(selectedModel.description) - \(selectedCarSaleState.description)"
    }

    var body: some View {
        VStack(alignment: .leading) {
            TitleView(title: "Automotive Sales")
            SubtitleView(subtitle: subtitle)
            AutomotiveSalesChartView(plotDataViewModel: plotDataViewModel, model: selectedModel, saleState: selectedCarSaleState)
                //.animation(.smooth)
            Divider()
            CarSalesSubView(title: "Model")
            Picker("", selection: $selectedModel) {
                ForEach(TeslaModel.allCases, id: \.self) { model in
                    Text(model.description)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            Divider()
            CarSalesSubView(title: "State")
            Picker("Select sale state", selection: $selectedCarSaleState) {
                ForEach(TeslaSaleState.allCases, id: \.self) { saleState in
                    Text(saleState.description)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            Divider()
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    NavigationStack {
        AutomotiveSalesView(plotDataViewModel: plotDataViewModel)
    }
}

struct AutomotiveSalesChartView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var rawSelectedDate: Date? = nil
    let model: TeslaModel
    let saleState: TeslaSaleState
    let yAxisLabel: String = "Cars"
    var countBarMarks: Int {
        plotDataViewModel.quarters.count
    }
    
    var body: some View {
        
        let xData = plotDataViewModel.extractQuarters()
        let yData: [Double]
        
        switch (model, saleState) {
        case (.model3Y, .delivered):
            yData = plotDataViewModel.extractData(property: .deliveredModel3Y)
        case (.model3Y, .produced):
            yData = plotDataViewModel.extractData(property: .producedModel3Y)
        case (.otherModels, .delivered):
            yData = plotDataViewModel.extractData(property: .deliveredOtherModels)
        case (.otherModels, .produced):
            yData = plotDataViewModel.extractData(property: .producedOtherModels)
        case (.allModels, .delivered):
            yData = plotDataViewModel.extractData(property: .deliveredCars)
        case (.allModels, .produced):
            yData = plotDataViewModel.extractData(property: .producedCars)
        }
                
        return Chart(0..<countBarMarks, id: \.self) {index in
                BarMark(x: .value("Quarter", xData[index]),
                        y: .value(yAxisLabel, yData[index]))
            if let rawSelectedDate {
                BarMark(x: .value("Value", rawSelectedDate, unit: .weekOfYear))
                    .foregroundStyle(.gray)
                    .zIndex(-1)
                    .annotation(position: .top,
                                spacing: 0,
                                overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopover()

                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func selectionPopover() -> some View {
        if let rawSelectedDate {
            VStack {
                Text(rawSelectedDate.formatted(.dateTime.year().quarter()))
                Text("Cars: 999.999")
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
}

struct CarSalesSubView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title) // Explicitly add the label here
                .font(.headline)
                .padding(.horizontal)
            Spacer()
            NavigationLink(destination: Text("Info")) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.blue)
                    .padding(.horizontal,20)
            }
            
        }
    }
}
