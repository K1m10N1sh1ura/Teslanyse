//
//  UIElements.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 03.03.24.
//

import SwiftUI
import Charts

struct TitleView: View {
    
    let title: String

    var body: some View {

        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading, 20)
            Image("Tesla_T_symbol")
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
}

struct SubtitleView: View {
    
    let subtitle: String
    
    var body: some View {
        Text(subtitle)
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.leading, 20)
    }
}


struct ExportButtonView: View {
    var chartView: Image = Image(systemName: "photo")
    
    var body: some View {
        Button(action: {
            let image = chartView.snapshot()
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }, label: {
            Label("Export Chart", systemImage: "photo")
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

struct InfoButtonSubView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title) // Explicitly add the label here
                .font(.headline)
                .padding(.horizontal)
            Spacer()
            NavigationLink(destination: Text("TBD")) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.blue)
                    .padding(.horizontal,20)
            }
        }
    }
}

struct ChartView: View {
    @StateObject var vm: MainViewModel
    @State private var rawSelectedDate: Date? = nil
    let xData: [Date]
    let yData: [Double]
    let numberFormat: NumberFormatType
    
    var body: some View {
        
        Chart(0..<vm.quarters.count, id: \.self) {index in
            switch SettingsClass.shared.chartStyle {
            case .barChart:
                BarMark(x: .value("Quarter", xData[index]),
                        y: .value("$", yData[index]), width: barMarkWidth)
                .foregroundStyle(SettingsClass.shared.chartColor)
            case .lineChart:
                LineMark(x: .value("Quarter", xData[index]),
                        y: .value("$", yData[index]))
                .foregroundStyle(SettingsClass.shared.chartColor)
            case .pointChart:
                PointMark(x: .value("Quarter", xData[index]),
                        y: .value("$", yData[index]))
                .foregroundStyle(SettingsClass.shared.chartColor)
            }

            if let rawSelectedDate {
                BarMark(x: .value("Value", rawSelectedDate, unit: .weekOfYear))
                    .foregroundStyle(.red)
                    .zIndex(-1)
                    .annotation(position: .top,
                                spacing: 0,
                                overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopover(yData: yData)
                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
        .frame(maxHeight: 300)
        .padding(.horizontal,20)
        .padding(.bottom,20)
        .animation(.smooth, value: yData)
    }
    
    
    @ViewBuilder
    func selectionPopover(yData: [Double]) -> some View {
        if let rawSelectedDate {
            VStack {
                if let indexOfQuarter = vm.getIndexOfQuarter(rawSelectedDate.formatted(.dateTime.year().quarter())) {
                    Text(vm.quarters[indexOfQuarter].quarter)
                    Text(yData[indexOfQuarter].customNumberFormat(formatType: numberFormat))
                }
                else {
                    Text("No data")
                }
            }
            .padding(6)
            .foregroundColor(.black)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
}

struct InfoButtonSubViewNew<InfoView: View>: View {
    let title: String
    let infoView: InfoView
    var body: some View {
        HStack {
            Text(title) // Explicitly add the label here
                .font(.headline)
                .padding(.horizontal)
            Spacer()
            NavigationLink(destination: infoView) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.blue)
                    .padding(.horizontal,20)
            }
        }
    }
}

struct InfoView<Info: WithDefinition & WithDescription & CaseIterable & Hashable>: View {
    var body: some View {
        ScrollView {
            ForEach(Array(Info.allCases), id: \.self) { item in
                VStack(alignment: .leading) {
                    Text(item.description)
                        .font(.title)
                    Text(item.definition)
                        .font(.footnote)
                        .padding(.vertical, 20)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure VStack takes full width
            }
        }
    }
}

struct PickerView<Info: CaseIterable & Hashable & WithDescription>: View {
    @Binding var selection: Info
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(Array(Info.allCases), id: \.self) {
                Text($0.description)
            }
        }
        .padding()
    }
}

