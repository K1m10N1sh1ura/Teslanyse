//
//  StartScreenView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI

struct StartScreenView: View {
    
    @StateObject var plotDataViewModel = PlotDataViewModel()

    var body: some View {
        List {
            Section("Total") {
                NavigationLink(destination: FinancialDataView()) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Automotive") {
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: plotDataViewModel)) {
                    Label("Sales", systemImage: "car.side")
                }
                NavigationLink(destination: AutomotiveFinancialsView(plotDataViewModel: plotDataViewModel)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Energy") {
                NavigationLink(destination: EnergySalesView(plotDataViewModel:plotDataViewModel)) {
                    Label("Storage", systemImage: "bolt.batteryblock")
                }
                NavigationLink(destination: Text("")) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Comparison") {
                Label("Quarters", systemImage: "clock.arrow.2.circlepath")
                Label("Other manufacturers", systemImage: "car.2.fill")
            }
        }
        .navigationTitle("Tesla Analytics")
    }
}

#Preview {
    NavigationView {
        StartScreenView()
    }
}
