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
        /**
         Extends the `Double` type to include a method for formatting numbers into custom string representations based on specified formats. The method `customNumberFormat(formatType:)` supports various formats including currency (with denominations such as dollars, millions, billions), percentages, plain numbers with scale abbreviations (e.g., K, M, B), and units of power and energy (Watt, Kilowatt, Megawatt, and their hourly equivalents).

         - Parameters:
            - formatType: An optional parameter of type `NumberFormatType` with a default value of `.dollar`. This parameter determines the format in which the number will be returned. Supported formats are `.dollar` for currency, `.percent` for percentages, `.number` for scaled numbers without any unit, `.power` for power consumption units, and `.energy` for energy units.

         - Returns: A `String` representing the formatted number based on the selected `formatType`. This includes adding appropriate suffixes (e.g., "$", "%", "K", "M", "B", "W", "KW", "MW", "Wh", "KWh", "MWh") and formatting the number with decimal places where appropriate. The method ensures that large numbers are presented in a human-readable format by scaling them down and appending relevant units or symbols.

         This extension method leverages `NumberFormatter` to format numbers, enabling customization such as the use of grouping separators and setting maximum fraction digits according to the format type chosen. It simplifies displaying numbers in a user-friendly manner across various contexts, including financial amounts, percentages, quantities, and measurements of power or energy.
         */
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
