//
//  UIElements.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 03.03.24.
//

import SwiftUI
import Charts

struct TitleView: View {
    let title: String

    var body: some View {

        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading, 20)
            Image("Tesla_T_symbol")
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
}

struct SubtitleView: View {
    let subtitle: String
    
    var body: some View {
        Text(subtitle)
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.leading, 20)
    }
}


struct ExportButtonView: View {
    var chartView: Image = Image(systemName: "photo")
    
    var body: some View {
        Button(action: {
            let image = chartView.snapshot()
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }, label: {
            Label("Export Chart", systemImage: "photo")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10.0)
                .padding()
        })
    }
}

struct InfoButtonView<InfoView: View>: View {
    let title: String
    let infoView: InfoView
    var body: some View {
        HStack {
            Text(title) // Explicitly add the label here
                .font(.headline)
                .padding(.horizontal)
            Spacer()
            NavigationLink(destination: infoView) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.blue)
                    .padding(.horizontal,20)
            }
        }
    }
}

struct InfoView<Info: WithDefinition & WithDescription & CaseIterable & Hashable>: View {
    var body: some View {
        ScrollView {
            ForEach(Array(Info.allCases), id: \.self) { item in
                VStack(alignment: .leading) {
                    Text(item.description)
                        .font(.title)
                    Text(item.definition)
                        .font(.footnote)
                        .padding(.vertical, 20)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure VStack takes full width
            }
        }
        .navigationTitle("Definitions")
    }
}

struct PickerView<Info: CaseIterable & Hashable & WithDescription>: View {
    @Binding var selection: Info
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(Array(Info.allCases), id: \.self) {
                Text($0.description)
            }
        }
        .padding()
    }
}

