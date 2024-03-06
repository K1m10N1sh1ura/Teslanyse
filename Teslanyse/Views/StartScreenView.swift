//
//  StartScreenView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI

struct StartScreenView: View {
    
    var vm = MainViewModel()

    var body: some View {
        List {
            Section("Total") {
                NavigationLink(destination: FinancialDataView(vm: vm)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Automotive") {
                NavigationLink(destination: AutomotiveSalesView(vm: vm)) {
                    Label("Global sales", systemImage: "car.side")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("China sales 🇨🇳", systemImage: "car.fill")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("Europe sales 🇪🇺", systemImage: "car.fill")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("US sales 🇺🇸", systemImage: "car.fill")
                }
                NavigationLink(destination: AutomotiveFinancialsView(vm: vm)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
            }
            Section("Energy") {
                NavigationLink(destination: EnergySalesView(vm:vm)) {
                    Label("Storage", systemImage: "bolt.batteryblock")
                }
                NavigationLink(destination: EnergyFinancialsView(vm: vm)) {
                    Label("Financials", systemImage: "dollarsign.square")
                }
                NavigationLink(destination: SuperchargerView(vm:vm)) {
                    Label("Superchargers", systemImage: "ev.charger.fill")
                }
            }

            Section("Comparison") {
                NavigationLink(destination: CompareQuartersView(vm: vm)) {
                    Label("Quarters", systemImage: "clock.arrow.2.circlepath")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("Other manufacturers", systemImage: "car.2.fill")
                }
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
