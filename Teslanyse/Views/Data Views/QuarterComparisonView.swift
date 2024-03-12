//
//  CompareQuartersView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 29.02.24.
//

import SwiftUI

struct CompareQuartersView: View {
    
    @StateObject var vm: MainViewModel
    @State private var selectionQuarterOne: String = "Q3 2023"
    @State private var selectionQuarterTwo: String = "Q4 2023"

    var firstQuarterIndex: Int? {
        vm.quarters.firstIndex {
            $0.quarter == selectionQuarterOne
        } ?? nil
    }
    
    var secondQuarterIndex: Int? {
        vm.quarters.firstIndex {
            $0.quarter == selectionQuarterTwo
        } ?? nil
    }
        
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Quarter")
            SubtitleView(subtitle: "Comparison")
        ScrollView {
                Divider()
                HStack {
                    Picker("", selection: $selectionQuarterOne) {
                        ForEach(vm.quarters) {
                            Text($0.quarter)
                                .tag($0.quarter)
                        }
                    }
                    Text("vs")
                    Picker("", selection: $selectionQuarterTwo) {
                        ForEach(vm.quarters) {
                            Text($0.quarter)
                                .tag($0.quarter)
                        }
                    }
                }
                .bold()
                .pickerStyle(.inline)
                .frame(height: 120)
                .animation(.easeIn, value: selectionQuarterOne)
                .animation(.easeIn, value: selectionQuarterTwo)
                Button(action: {
                    selectionQuarterOne = "Q3 2023"
                    selectionQuarterTwo = "Q4 2023"
                }, label: {
                    Label("Latest", systemImage: "chart.line.uptrend.xyaxis")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10.0)
                        .padding()
                        .frame(height: 60)
                })
                Divider()
                    ForEach(QuarterDataEnum.allCases, id: \.self) {param in
                        if let firstQuarterIndex, let secondQuarterIndex {
                            ExtractedView(title: param.description,
                                          valueFirstQuarter: vm.extractData(property: param)[firstQuarterIndex],
                                          valueSecondQuarter: vm.extractData(property: param)[secondQuarterIndex], numberFormat: getNumberFormat(of: param))
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private func getNumberFormat(of param: QuarterDataEnum) -> NumberFormatType {
        let numberFormat: NumberFormatType
        switch param {
        case .margin:
            numberFormat = .percent
        case .automotiveMargin:
            numberFormat = .percent
        case .deliveredCars:
            numberFormat = .number
        case .producedCars:
            numberFormat = .number
        case .deliveredModel3Y:
            numberFormat = .number
        case .deliveredOtherModels:
            numberFormat = .number
        case .producedModel3Y:
            numberFormat = .number
        case .producedOtherModels:
            numberFormat = .number
        case .energyStorage:
            numberFormat = .power
        case .energyMargin:
            numberFormat = .percent
        case .solarDeployed:
            numberFormat = .energy
        case .superchargerStations:
            numberFormat = .number
        case .superchargerConnectors:
            numberFormat = .number
        case .superchargerStationsAccumulated:
            numberFormat = .number
        case .superchargerConnectorsAccumulated:
            numberFormat = .number
        default:
            numberFormat = .dollar
        }
        return numberFormat
    }
    
}

#Preview {
    NavigationStack {
        CompareQuartersView(vm: vmPreview)
    }
}

struct ExtractedView: View {
    let title: String
    let valueFirstQuarter: Double
    let valueSecondQuarter: Double
    let numberFormat: NumberFormatType
    
    var deviation: Double { (valueSecondQuarter - valueFirstQuarter) / valueFirstQuarter }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            HStack {
                Spacer()
                Text(valueFirstQuarter.customNumberFormat(formatType: numberFormat))
                    .font(.subheadline)
                    .padding(.horizontal)
                Spacer()
                Text("\(deviation * 100, specifier: "%.1f") %")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .background(deviation >= 0.0 ? .green : .red)
                    .cornerRadius(10)
                Spacer()
                Text(valueSecondQuarter.customNumberFormat(formatType: numberFormat))
                    .font(.subheadline)
                    .padding(.horizontal)
                Spacer()
            }
        }
        Divider()
    }
}
