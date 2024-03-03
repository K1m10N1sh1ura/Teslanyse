//
//  SuperchargerView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 01.03.24.
//

import SwiftUI

struct SuperchargerView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var selector: SuperchargerOption = .stations
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Superchargers")
            SubtitleView(subtitle: "Network")
        }
    }
}

#Preview {
    SuperchargerView(plotDataViewModel: plotDataViewModel)
}
