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
                NavigationLink(destination: FinancialDataView(plotDataViewModel: plotDataViewModel)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Automotive") {
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: plotDataViewModel)) {
                    Label("Global sales", systemImage: "car.side")
                }
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: plotDataViewModel)) {
                    Label("China sales 🇨🇳", systemImage: "car.fill")
                }
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: plotDataViewModel)) {
                    Label("Europe sales 🇪🇺", systemImage: "car.fill")
                }
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: plotDataViewModel)) {
                    Label("US sales 🇺🇸", systemImage: "car.fill")
                }
                NavigationLink(destination: AutomotiveFinancialsView(plotDataViewModel: plotDataViewModel)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Energy") {
                NavigationLink(destination: EnergySalesView(plotDataViewModel:plotDataViewModel)) {
                    Label("Storage", systemImage: "bolt.batteryblock")
                }
                NavigationLink(destination: EnergyFinancialsView(plotDataViewModel: plotDataViewModel)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
                NavigationLink(destination: SuperchargerView(plotDataViewModel:plotDataViewModel)) {
                    Label("Superchargers", systemImage: "ev.charger.fill")
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
