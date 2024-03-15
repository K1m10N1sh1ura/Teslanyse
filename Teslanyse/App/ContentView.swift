//
//  ContentView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import SwiftUI

// global: used for previews only
let vmPreview = MainViewModel(dataService: DataService<EarningsApiDataModel>())
let vmChinaSalesPreview = ChinaSalesViewModel(dataService: DataService<ChinaSalesApiDataModel>())

struct ContentView: View {
    let vm = MainViewModel(dataService: DataService<EarningsApiDataModel>())

    var body: some View {
        NavigationStack {
            StartScreenView(vm: vm)
        }
    }
}

#Preview {
    ContentView()
}
