//
//  ChartColorView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 09.03.24.
//

import SwiftUI

struct ChartColorView: View {
    @State private var selection: ChartColor
    
    init() {
        switch chartColor {
        case .blue:
            selection = .blue
        case .green:
            selection = .green
        case .red:
            selection = .red
        case .gray:
            selection = .gray
        case .yellow:
            selection = .yellow
        default:
            selection = .gray
        }
    }
    var body: some View {
        VStack {
            TitleView(title: "Chart Settings")
            SubtitleView(subtitle: "Color")
            Picker("", selection: $selection) {
                ForEach(ChartColor.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: selection) {
                switch selection {
                case .blue:
                    chartColor = .blue
                case .green:
                    chartColor = .green
                case .red:
                    chartColor = .red
                case .gray:
                    chartColor = .gray
                case .yellow:
                    chartColor = .yellow
                }
            }
        }
    }
}

#Preview {
    ChartColorView()
}
