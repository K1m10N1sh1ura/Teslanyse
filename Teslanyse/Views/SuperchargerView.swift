//
//  SuperchargerView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 01.03.24.
//

import SwiftUI

struct SuperchargerView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    SuperchargerView(plotDataViewModel: plotDataViewModel)
}
