//
//  AppModels.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import Foundation

var plotDataViewModel = PlotDataViewModel()

struct TeslaDataModel: Codable {
    var quarter: [String:String] = [:]
    var profit: [String:Int] = [:]
    var revenue: [String:Int] = [:]
    var automotiveRevenue: [String:Int] = [:]
    var automotiveCostOfRevenue: [String:Int] = [:]
    var deliveredCars: [String:Int] = [:]
    var deliveredModel3Y: [String:Int] = [:]
    var deliveredOtherModels: [String:Int] = [:]
    var producedCars: [String:Int] = [:]
    var producedModel3Y: [String:Int] = [:]
    var producedOtherModels: [String:Int] = [:]
    var energyRevenue: [String:Int] = [:]
    var energyCostOfRevenue: [String:Int] = [:]
    var energyStorage: [String:Int] = [:]
    var solarDeployed: [String:Int] = [:]
    var superchargerStationsAccumulated: [String:Int] = [:]
    var superchargerConnectorsAccumulated: [String:Int] = [:]
}

struct QuarterData: Identifiable {
    let id = UUID()
    let quarter: String
    let revenue: Int
    let profit: Int
    let automotiveRevenue: Int
    let automotiveCostOfRevenue: Int
    let deliveredCars: Int
    let producedCars: Int
    let energyRevenue: Int
    let energyCostOfRevenue: Int
    let energyStorage: Int
    let deliveredModel3Y: Int
    let deliveredOtherModels: Int
    let producedModel3Y: Int
    let producedOtherModels: Int
    let solarDeployed: Int
    let superchargerStationsAccumulated: Int
    let superchargerConnectorsAccumulated: Int
    
    var margin: Double {
        return Double(profit) / Double(revenue)
    }
    var automotiveProfit: Int {
        return automotiveRevenue - automotiveCostOfRevenue
    }
    var automotiveMargin: Double {
        return Double(automotiveProfit) / Double(automotiveRevenue)
    }
    var energyProfit: Int {
        return energyRevenue - energyCostOfRevenue
    }
    var energyMargin: Double {
        return Double(energyProfit) / Double(energyRevenue)
    }
    var automotiveCostOfGoodsSold: Int {
        return Int(Double(automotiveCostOfRevenue) / Double(producedCars))
    }
    var energyCostOfGoodsSold: Int {
        return Int(Double(energyCostOfRevenue*1000000) / Double(energyStorage))
    }
    var date: Date {
        // Convert quarter string to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Q'q yyyy"
        return dateFormatter.date(from: quarter) ?? Date()
    }
}

enum QuarterDataEnum: CaseIterable {
    case revenue
    case profit
    case margin
    case automotiveRevenue
    case automotiveCostOfRevenue
    case automotiveProfit
    case automotiveMargin
    case automotiveCostOfGoodsSold
    case deliveredCars
    case producedCars
    case deliveredModel3Y
    case deliveredOtherModels
    case producedModel3Y
    case producedOtherModels
    case energyRevenue
    case energyCostOfRevenue
    case energyStorage
    case energyProfit
    case energyMargin
    case energyCostOfGoodsSold
    case solarDeployed
    case superchargerStationsAccumulated
    case superchargerConnectorsAccumulated
}

enum TeslaModel: CaseIterable {
    case model3Y
    case otherModels
    case allModels
    
    var description: String {
        switch self {
        case .model3Y:
            return "Model 3/Y"
        case .otherModels:
            return "Other models"
        case .allModels:
            return "Total"
        }
    }
}

enum TeslaSaleState: CaseIterable {
    case produced
    case delivered
    var description: String {
        switch self {
        case .produced:
            return "Produced"
        case .delivered:
            return "Delivered"
        }
    }
}


enum FinancialDataOption: CaseIterable {
    case revenue
    case profit
    case grossGAAPMargin
//  case costOfRevenue
//    case operatingExpenses
//    case incomeFromOperations
//    case adjustedEBITDA
//    case adjustedEBITDAMargin
//    case netIncomeGAAP
//    case netIncomeNonGAAP
//    case EPSGAAP
//    case EPSNonGAAP
//    case cash
//    case freeCashFlow
//    case netCashProvidedByOperatingActivities
//    case capitalExpenditures
//    case researchAndDevelopementOperatingExpenses
//    case sellingGeneralAndAdministrativeOperatingExpenses
//    case restructuringAndOtherOperatingExpenses
    
    var description: String {
        switch self {
        case .revenue:
            return "Revenue"

        case .profit:
            return "Profit"
        case .grossGAAPMargin:
            return "Gross GAAP margin"
        }
    }
}

enum AutomotiveFinancialDataOption: CaseIterable {
    case revenue
    case costOfRevenue
    case profit
    case margin
    case cogs
    
//    case automotiveSalesRevenue
//    case regulatoryCreditRevenue
//    case automotiveLeasingRevenue
//    case automotiveCostOfRevenue
//    case leasingCostOfRevenue
    
    var description: String {
        switch self {
        case .revenue:
            return "Revenue"
        case .costOfRevenue:
            return "Cost of revenue"
        case .profit:
            return "Profit"
        case .margin:
            return "Margin"
        case .cogs:
            return "Cost of goods sold"
        }
    }
}

enum EnergyOptions: CaseIterable {
    case storageDeployed
    case solarDeployed
    
    var description: String {
        switch self {
        case .storageDeployed:
            return "Storage"
        case .solarDeployed:
            return "Solar"
        }
    }
}

enum EnergyFinancialDataOption: CaseIterable {
    case revenue
    case costOfRevenue
    case profit
    case margin
    case cogs
    
    var description: String {
        switch self {
        case .revenue:
            return "Revenue"
        case .costOfRevenue:
            return "Cost of revenue"
        case .profit:
            return "Profit"
        case .margin:
            return "Margin"
        case .cogs:
            return "Cost of goods sold"
        }
    }
}

enum SuperchargerOption: CaseIterable {
    case stations
    case connectors
    
    var desciption: String {
        switch self {
        case .stations:
            return "Stations"
        case .connectors:
            return "Connectors"
        }
    }
}
