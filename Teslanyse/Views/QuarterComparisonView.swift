//
//  CompareQuartersView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 29.02.24.
//

import SwiftUI

struct CompareQuartersView: View {
    
    @StateObject var vm: MainViewModel
    @State var selectionQuarterOne: String = ""
    @State var selectionQuarterTwo: String = ""

    var firstQuarterIndex: Int {
        vm.quarters.firstIndex {
            $0.quarter == selectionQuarterOne
        } ?? 0
    }
    
    var secondQuarterIndex: Int {
        vm.quarters.firstIndex {
            $0.quarter == selectionQuarterTwo
        } ?? 1
    }
        
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Quarter")
            SubtitleView(subtitle: "Comparison")
            Divider()
            HStack {
                VStack {
                    Text("From")
                    Picker("", selection: $selectionQuarterOne) {
                        ForEach(vm.quarters) {
                            Text($0.quarter)
                        }
                    }
                }
                VStack {
                    Text("To")
                    Picker("", selection: $selectionQuarterTwo) {
                        ForEach(vm.quarters) {
                            Text($0.quarter)
                        }
                    }
                }
            }
            .bold()
            .pickerStyle(.inline)
            .frame(height: 150)
            ScrollView {
//                ForEach(QuarterDataEnum.allCases, id: \.self) {param in
//                    if !vm.quarters.isEmpty {
//                        ExtractedView(title: param.description,
//                                      valueFirstQuarter: vm.extractData(property: param)[firstQuarterIndex],
//                                      valueSecondQuarter: vm.extractData(property: param)[secondQuarterIndex])
//                    }
//                }
                Text("\(selectionQuarterTwo)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    NavigationStack {
        CompareQuartersView(vm: vm)
    }
}

struct ExtractedView: View {
    let title: String
    let valueFirstQuarter: Double
    let valueSecondQuarter: Double
    
    var deviation: Double { (valueSecondQuarter - valueFirstQuarter) / valueSecondQuarter }
    
    var body: some View {
        Divider()
        VStack {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            HStack {
                Spacer()
                Text(Int(valueFirstQuarter), format: .number.notation(.compactName))
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
                Text(Int(valueSecondQuarter), format: .number.notation(.compactName))
                    .font(.subheadline)
                    .padding(.horizontal)
                Spacer()
            }
        }
        Divider()
    }
}
