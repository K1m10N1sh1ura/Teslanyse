//
//  CompareQuartersView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 29.02.24.
//

import SwiftUI

struct CompareQuartersView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var selectionQuarterOne: String = ""
    @State var selectionQuarterTwo: String = ""

    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Quarter")
            SubtitleView(subtitle: "Comparison")
            Divider()
            HStack {
                VStack {
                    Text("From")
                    Picker("From", selection: $selectionQuarterOne) {
                        ForEach(plotDataViewModel.quarters) { quarter in
                            Text(quarter.quarter)
                        }
                    }
                        .bold()
                }
                VStack {
                    Text("To")
                    Picker("To", selection: $selectionQuarterTwo) {
                        ForEach(plotDataViewModel.quarters) { quarter in
                            Text(quarter.quarter)
                        }
                    }
                    .bold()
                }
            }
            .pickerStyle(.inline)
            .frame(height: 120)
            ScrollView {
                ExtractedView(title: "Revenue")
                ExtractedView(title: "Profit")
                ExtractedView(title: "Margin")
                ExtractedView(title: "Revenue")
                ExtractedView(title: "Profit")
                ExtractedView(title: "Margin")
                ExtractedView(title: "Revenue")
                ExtractedView(title: "Profit")
                ExtractedView(title: "Margin")
                ExtractedView(title: "Revenue")
                ExtractedView(title: "Profit")
                ExtractedView(title: "Margin")
            }


        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CompareQuartersView(plotDataViewModel: plotDataViewModel)
    }
}

struct ExtractedView: View {
    let title: String
    var body: some View {
        Divider()
        VStack {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            HStack {
                Spacer()
                Text("10B$")
                    .font(.subheadline)
                    .padding(.horizontal)
                Spacer()
                Text("+ 100 %")
                    .font(.subheadline)
                    .foregroundStyle(.green)
                    .padding(.horizontal)
                Spacer()
                Text("20B$")
                    .font(.subheadline)
                    .padding(.horizontal)
                Spacer()
            }
        }
        Divider()
    }
}
