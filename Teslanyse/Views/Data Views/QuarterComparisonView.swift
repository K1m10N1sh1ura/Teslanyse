//
//  CompareQuartersView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 29.02.24.
//

import SwiftUI

struct CompareQuartersView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @StateObject private var quarterCompareViewModel: QuarterComparisonViewModel
    
    init(vm: QuarterDataViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _quarterCompareViewModel = StateObject(wrappedValue: QuarterComparisonViewModel(vm: vm))
    }


        
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Quarter")
            SubtitleView(subtitle: "Comparison")
            ScrollView {
                Divider()
                QuarterPickerView(vm: vm, selectionQuarterOne: $quarterCompareViewModel.selectionQuarterOne, selectionQuarterTwo: $quarterCompareViewModel.selectionQuarterTwo)
                LatestButtonView(selectionQuarterOne: $quarterCompareViewModel.selectionQuarterOne, selectionQuarterTwo: $quarterCompareViewModel.selectionQuarterTwo)
                Divider()
                ForEach(QuarterDataEnum.allCases, id: \.self) {param in
                    if let firstQuarterIndex = quarterCompareViewModel.firstQuarterIndex,
                        let secondQuarterIndex = quarterCompareViewModel.secondQuarterIndex {
                        
                        ExtractedView(title: param.description,
                                      valueFirstQuarter: vm.extractData(property: param)[firstQuarterIndex],
                                      valueSecondQuarter: vm.extractData(property: param)[secondQuarterIndex], numberFormat: quarterCompareViewModel.getNumberFormat(of: param))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        CompareQuartersView(vm: quarterDataVM)
    }
}

struct ExtractedView: View {
    let title: String
    let valueFirstQuarter: Double
    let valueSecondQuarter: Double
    let numberFormat: NumberFormatType
    
    var deviation: Double {
        guard valueFirstQuarter != 0 else { return 0 }
        return (valueSecondQuarter - valueFirstQuarter) / abs(valueFirstQuarter)
    }
    
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

struct LatestButtonView: View {
    @Binding var selectionQuarterOne: String
    @Binding var selectionQuarterTwo: String
    var body: some View {
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
    }
}

struct QuarterPickerView: View {
    @ObservedObject var vm: QuarterDataViewModel
    @Binding var selectionQuarterOne: String
    @Binding var selectionQuarterTwo: String
    var body: some View {
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
    }
}
