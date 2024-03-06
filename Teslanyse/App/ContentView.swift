//
//  ContentView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import SwiftUI

var vm = MainViewModel()

struct ContentView: View {
    var body: some View {
        NavigationStack {
            StartScreenView()
        }
    }
}

#Preview {
    ContentView()
}
