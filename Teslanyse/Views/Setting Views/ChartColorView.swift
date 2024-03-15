//
//  ChartColorView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 09.03.24.
//

import SwiftUI

struct ChartColorView: View {
    @State private var selection: ChartColor = .blue
    
    var body: some View {
        VStack {
            TitleView(title: "Chart Settings")
            SubtitleView(subtitle: "Color")
            Picker("", selection: $selection) {
                ForEach(ChartColor.allCases, id: \.self) {
                    Text($0.description)
                        .tag($0.description)
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: selection) {
                saveChartColor()
            }
            .onAppear {
                selection = loadChartColor()
            }
        }
    }
    
    private func loadChartColor() -> ChartColor {
        switch SettingsClass.chartColor {
        case .blue:
            return .blue
        case .green:
            return .green
        case .red:
            return .red
        case .gray:
            return .gray
        case .yellow:
            return .yellow
        default:
            return .gray
        }
    }
    
    private func saveChartColor() {
        switch selection {
        case .blue:
            SettingsClass.chartColor = .blue
        case .green:
            SettingsClass.chartColor = .green
        case .red:
            SettingsClass.chartColor = .red
        case .gray:
            SettingsClass.chartColor = .gray
        case .yellow:
            SettingsClass.chartColor = .yellow
        }
    }
}

#Preview {
    ChartColorView()
}
