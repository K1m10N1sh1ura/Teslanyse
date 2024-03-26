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
            Section(header: Text("Financials").bold()) {
                NavigationLink(destination: FinancialDataView(vm: vm)) {
                    Label("Total", systemImage: "dollarsign.square.fill")
                }
                NavigationLink(destination: AutomotiveFinancialsView(vm: vm)) {
                    Label("Automotive", systemImage: "car.side.fill")
                }
                NavigationLink(destination: EnergyFinancialsView(vm: vm)) {
                    Label("Energy and storage", systemImage: "bolt.batteryblock.fill")
                }
                NavigationLink(destination: ServiceFinancialsView(vm: vm)) {
                    Label("Service and other", systemImage: "hammer.fill")
                }
            }
            Section(header: Text("Sales and numbers").bold()) {
                NavigationLink(destination: AutomotiveSalesView(vm: vm)) {
                    Label("Automotive", systemImage: "car.side.fill")
                }
                NavigationLink(destination: EnergySalesView(vm:vm)) {
                    Label("Energy and storage", systemImage: "bolt.batteryblock.fill")
                }
                NavigationLink(destination: SuperchargerView(vm:vm)) {
                    Label("Superchargers", systemImage: "ev.charger.fill")
                }
            }
            Section(header: Text("Comparisons").bold()) {
                NavigationLink(destination: CompareQuartersView(vm: vm)) {
                    Label("Quarters", systemImage: "clock.arrow.2.circlepath")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("Years", systemImage: "clock.arrow.2.circlepath")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("Other manufacturers", systemImage: "car.2")
                }
            }
            Section (header: Text("News").bold()) {
                NavigationLink(destination: Text("Coming soon")) {
                    Label("General", systemImage: "newspaper")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("Robotics and AI", systemImage: "newspaper")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("Automotive and FSD", systemImage: "newspaper")
                }
                NavigationLink(destination: Text("Coming soon")) {
                    Label("Energy", systemImage: "newspaper")
                }

            }
            Section(header: Text("Settings").bold()) {
                NavigationLink(destination: ChartStyleView()) {
                    Label("Chart style", systemImage: "chart.xyaxis.line")
                }
                NavigationLink(destination: ChartColorView()) {
                    Label("Chart color", systemImage: "paintbrush")
                }
            }
        }
        .navigationTitle("Teslanyse")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                TitleView(title: "Teslanyse")
//            }
//        }
    }
}

#Preview {
    NavigationView {
        StartScreenView(vm: quarterDataVM)
    }
}
