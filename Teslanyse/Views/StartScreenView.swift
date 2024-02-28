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
                    Label("Car Sales", systemImage: "car.side")
                }
                NavigationLink(destination: EnergySalesView()) {
                    Label("Automotive Business", systemImage: "bolt.batteryblock")
                }
            }
            Section("Energy") {
                NavigationLink(destination: EnergySalesView()) {
                    Label("Deployed Storage", systemImage: "bolt.batteryblock")
                }
                NavigationLink(destination: EnergySalesView()) {
                    Label("Energy Business", systemImage: "bolt.batteryblock")
                }
            }
        }
        .navigationTitle("Menu")
    }
}

#Preview {
    NavigationView {
        StartScreenView()
    }
}
