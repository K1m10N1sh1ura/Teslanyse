//
//  QuarterComparisonViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 18.03.24.
//

import Foundation
import SwiftUI

class QuarterComparisonViewModel: ObservableObject {
    
    let vm: QuarterDataViewModel
    @Published var selectionQuarterOne: String
    @Published var selectionQuarterTwo: String
    @Published var selectedParams: [QuarterDataEnum: Bool] = Dictionary(uniqueKeysWithValues: QuarterDataEnum.allCases.map { ($0, true) })
    @Published var isEditing: Bool = false

    init(vm: QuarterDataViewModel, selectionQuarterOne: String = "Q3 2023", selectionQuarterTwo: String = "Q4 2023") {
        self.vm = vm
        self.selectionQuarterOne = selectionQuarterOne
        self.selectionQuarterTwo = selectionQuarterTwo
    }
    
    var firstQuarterIndex: Int? {
        vm.quarters.firstIndex {
            $0.quarter == selectionQuarterOne
        } ?? nil
    }
    
    var secondQuarterIndex: Int? {
        vm.quarters.firstIndex {
            $0.quarter == selectionQuarterTwo
        } ?? nil
    }
    
    func getNumberFormat(of param: QuarterDataEnum) -> NumberFormatType {
        let numberFormat: NumberFormatType
        switch param {
        case .margin:
            numberFormat = .percent
        case .operatingMargin:
            numberFormat = .percent
        case .automotiveMargin:
            numberFormat = .percent
        case .automotiveLeasingMargin:
            numberFormat = .percent
        case .deliveredCars:
            numberFormat = .number
        case .producedCars:
            numberFormat = .number
        case .deliveredModel3Y:
            numberFormat = .number
        case .deliveredOtherModels:
            numberFormat = .number
        case .producedModel3Y:
            numberFormat = .number
        case .producedOtherModels:
            numberFormat = .number
        case .energyStorage:
            numberFormat = .power
        case .energyMargin:
            numberFormat = .percent
        case .serviceMargin:
            numberFormat = .percent
        case .solarDeployed:
            numberFormat = .energy
        case .superchargerStations:
            numberFormat = .number
        case .superchargerConnectors:
            numberFormat = .number
        case .superchargerStationsAccumulated:
            numberFormat = .number
        case .superchargerConnectorsAccumulated:
            numberFormat = .number
        default:
            numberFormat = .dollar
        }
        return numberFormat
    }
}
