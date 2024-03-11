//
//  ContentView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import SwiftUI

// used for previews only
let vmPreview = MainViewModel()

struct ContentView: View {
    let vm = MainViewModel()

    var body: some View {
        NavigationStack {
            StartScreenView(vm: vm)
        }
    }
}

#Preview {
    ContentView()
}
