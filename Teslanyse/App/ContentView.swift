//
//  ContentView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import SwiftUI

// global: used for previews only
let quarterDataVM = QuarterDataViewModel(dataService: DataService<EarningsApiDataModel>())
let weekDataVM = WeekDataViewModel(dataService: DataService<ChinaSalesApiDataModel>())

struct ContentView: View {
    let vm = QuarterDataViewModel(dataService: DataService<EarningsApiDataModel>())

    var body: some View {
        NavigationStack {
            StartScreenView(vm: vm)
        }
    }
}

#Preview {
    ContentView()
}
