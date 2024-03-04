//
//  UIElements.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 03.03.24.
//

import SwiftUI

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
    var body: some View {
        Button(action: {
            
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
