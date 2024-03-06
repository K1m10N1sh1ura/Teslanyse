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
            NavigationLink(destination: Text("Info")) {
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
                BarMark(x: .value("Quarter", xData[index]),
                        y: .value("$", yData[index]), width: barMarkWidth)
            if let rawSelectedDate {
                BarMark(x: .value("Value", rawSelectedDate, unit: .weekOfYear))
                    .foregroundStyle(.gray)
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