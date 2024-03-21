//
//  StartScreenView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI

struct StartScreenView: View {
    
    let vm: QuarterDataViewModel

    var body: some View {
        List {
            Section("Financials") {
                NavigationLink(destination: FinancialDataView(vm: vm)) {
                    Label("Total", systemImage: "dollarsign.square")
                }
                NavigationLink(destination: AutomotiveFinancialsView(vm: vm)) {
                    Label("Automotive", systemImage: "car.side")
                }
                NavigationLink(destination: EnergyFinancialsView(vm: vm)) {
                    Label("Energy and storage", systemImage: "bolt.batteryblock")
                }
                NavigationLink(destination: ServiceFinancialsView(vm: vm)) {
                    Label("Service and other", systemImage: "hammer")
                }
            }
            Section("Sales and numbers") {
                NavigationLink(destination: AutomotiveSalesView(vm: vm)) {
                    Label("Automotive", systemImage: "car.side")
                }
                NavigationLink(destination: EnergySalesView(vm:vm)) {
                    Label("Energy and storage", systemImage: "bolt.batteryblock")
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
            Section("Prototypes") {
                NavigationLink(destination: CustomMetricView(vm: vm)) {
                    Label("Custom metrics", systemImage: "clock.arrow.2.circlepath")
                }
            }
            Section("Settings") {
                NavigationLink(destination: ChartStyleView()) {
                    Label("Chart style", systemImage: "chart.xyaxis.line")
                }
                NavigationLink(destination: ChartColorView()) {
                    Label("Chart color", systemImage: "paintbrush")
                }
            }
        }
        .navigationTitle("Tesla Analytics")
        
    }
}

#Preview {
    NavigationView {
        StartScreenView(vm: quarterDataVM)
    }
}
