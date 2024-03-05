//
//  StartScreenView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI

struct StartScreenView: View {
    
    var vm = PlotDataViewModel()

    var body: some View {
        List {
            Section("Total") {
                NavigationLink(destination: FinancialDataView(plotDataViewModel: vm)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Automotive") {
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: vm)) {
                    Label("Global sales", systemImage: "car.side")
                }
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: vm)) {
                    Label("China sales 🇨🇳", systemImage: "car.fill")
                }
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: vm)) {
                    Label("Europe sales 🇪🇺", systemImage: "car.fill")
                }
                NavigationLink(destination: AutomotiveSalesView(plotDataViewModel: vm)) {
                    Label("US sales 🇺🇸", systemImage: "car.fill")
                }
                NavigationLink(destination: AutomotiveFinancialsView(plotDataViewModel: vm)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Energy") {
                NavigationLink(destination: EnergySalesView(plotDataViewModel:vm)) {
                    Label("Storage", systemImage: "bolt.batteryblock")
                }
                NavigationLink(destination: EnergyFinancialsView(plotDataViewModel: vm)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
                NavigationLink(destination: SuperchargerView(plotDataViewModel:vm)) {
                    Label("Superchargers", systemImage: "ev.charger.fill")
                }
            }

            Section("Comparison") {
                NavigationLink(destination: CompareQuartersView(vm: vm)) {
                    Label("Quarters", systemImage: "clock.arrow.2.circlepath")
                }
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
