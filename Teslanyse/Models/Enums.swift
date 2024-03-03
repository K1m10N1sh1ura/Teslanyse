//
//  Enums.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 03.03.24.
//

import Foundation


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
    case model3Y, otherModels, allModels
    
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
    case produced, delivered
    
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
    case revenue, profit, grossGAAPMargin
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
    case revenue, costOfRevenue, profit, margin, cogs
    
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
    case storageDeployed, solarDeployed
    
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
    case revenue, costOfRevenue, profit, margin, cogs
    
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
    case stations, connectors
    
    var desciption: String {
        switch self {
        case .stations:
            return "Stations"
        case .connectors:
            return "Connectors"
        }
    }
}