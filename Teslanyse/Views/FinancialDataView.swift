//
//  FinancialDataView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI

struct FinancialDataView: View {
    
    @StateObject var plotDataViewModel = PlotDataViewModel()

    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Summary")
            FinancialsChartView()
        }
    }
}

#Preview {
    FinancialDataView()
}

struct FinancialsChartView: View {
    var body: some View {
        Text("")
    }
}

