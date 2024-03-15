//
//  ChartStyleView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 09.03.24.
//

import SwiftUI

struct ChartStyleView: View {
    @State private var selection: ChartStyle = SettingsClass.chartStyle

    var body: some View {
        VStack {
            TitleView(title: "Chart Settings")
            SubtitleView(subtitle: "Style")
            Picker("", selection: $selection) {
                ForEach(ChartStyle.allCases, id: \.self) {
                    Text($0.description)
                        .tag($0.description)
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: selection) {
                SettingsClass.chartStyle = selection
            }
            .onAppear {
                selection = SettingsClass.chartStyle
            }
        }
    }
}

#Preview {
    ChartStyleView()
}
