//
//  ContentView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import SwiftUI

var vm = MainViewModel()
var chartStyle: ChartStyle = .barChart
var chartColor: Color = .blue

struct ContentView: View {
    var vm = MainViewModel()

    var body: some View {
        NavigationStack {
            StartScreenView(vm: vm)
        }
    }
}

#Preview {
    ContentView()
}
