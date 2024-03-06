//
//  Extensions.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 06.03.24.
//

import Foundation
import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension Double {
    func customNumberFormat(formatType: NumberFormatType = .dollar) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesGroupingSeparator = false
        
        var formattedNumber: String
        
        switch formatType {
        case .dollar:
            if abs(self) >= 1_000_000_000 {
                numberFormatter.maximumFractionDigits = 2
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000_000_000)) ?? ""
                formattedNumber += "B$"
            } else if abs(self) >= 1_000_000 {
                numberFormatter.maximumFractionDigits = 2
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000_000)) ?? ""
                formattedNumber += "M$"
            } else if abs(self) >= 1_000 {
                numberFormatter.maximumFractionDigits = 2
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000)) ?? ""
                formattedNumber += "k$"
            } else {
                formattedNumber = numberFormatter.string(from: NSNumber(value: self)) ?? ""
                formattedNumber += "$"
            }
        case .percent:
            numberFormatter.maximumFractionDigits = 1
            formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) * 100)) ?? ""
            formattedNumber += "%"
        case .number:
            if abs(self) >= 1_000_000_000 {
                numberFormatter.maximumFractionDigits = 2
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000_000_000)) ?? ""
                formattedNumber += "B"
            } else if abs(self) >= 1_000_000 {
                numberFormatter.maximumFractionDigits = 2
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000_000)) ?? ""
                formattedNumber += "M"
            } 
            else if abs(self) >= 1_000 {
                numberFormatter.maximumFractionDigits = 2
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000)) ?? ""
                formattedNumber += "K"
            }
            else {
                formattedNumber = numberFormatter.string(from: NSNumber(value: self)) ?? ""
            }
        case .power:
            if abs(self) >= 1_000_000 {
                numberFormatter.maximumFractionDigits = 0
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000_000)) ?? ""
                formattedNumber += "MWh"
            } else if abs(self) >= 1_000 {
                numberFormatter.maximumFractionDigits = 0
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000)) ?? ""
                formattedNumber += "KWh"
            }
            else {
                formattedNumber = numberFormatter.string(from: NSNumber(value: self)) ?? ""
                formattedNumber += "Wh"
            }
        case .energy:
            if abs(self) >= 1_000_000 {
                numberFormatter.maximumFractionDigits = 0
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000_000)) ?? ""
                formattedNumber += "MW"
            } else if abs(self) >= 1_000 {
                numberFormatter.maximumFractionDigits = 0
                formattedNumber = numberFormatter.string(from: NSNumber(value: Double(self) / 1_000)) ?? ""
                formattedNumber += "KW"
            }
            else {
                formattedNumber = numberFormatter.string(from: NSNumber(value: self)) ?? ""
                formattedNumber += "W"
            }
        }
        return formattedNumber
    }
}
