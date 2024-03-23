//
//  AppModels.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import Foundation

struct EarningsApiDataModel: Codable {
    var quarter: [String:String] = [:]
    var profit: [String:Int] = [:]
    var revenue: [String:Int] = [:]
    var operatingExpenses: [String:Int] = [:]
    var cash: [String:Int] = [:]
    var freeCashFlow: [String:Int] = [:]
    var researchAndDevelopementExpenses: [String:Int] = [:]
    var sellingGeneralAndAdministrativeExpenses: [String:Int] = [:]
    var restructuringExpenses: [String:Int] = [:]
    // automotive
    var automotiveRevenue: [String:Int] = [:]
    var automotiveCostOfRevenue: [String:Int] = [:]
    var automotiveRegulatoryCreditsRevenue: [String:Int] = [:]
    var automotiveLeasingRevenue: [String:Int] = [:]
    var automotiveLeasingCostOfRevenue: [String:Int] = [:]
    var deliveredCars: [String:Int] = [:]
    var deliveredModel3Y: [String:Int] = [:]
    var deliveredOtherModels: [String:Int] = [:]
    var producedCars: [String:Int] = [:]
    var producedModel3Y: [String:Int] = [:]
    var producedOtherModels: [String:Int] = [:]
    // energy
    var energyRevenue: [String:Int] = [:]
    var energyCostOfRevenue: [String:Int] = [:]
    var energyStorage: [String:Int] = [:]
    var solarDeployed: [String:Int] = [:]
    // service
    var serviceRevenue: [String:Int] = [:]
    var serviceCostOfRevenue: [String:Int] = [:]
    // superchargers
    var superchargerStationsAccumulated: [String:Int] = [:]
    var superchargerConnectorsAccumulated: [String:Int] = [:]
}

struct QuarterData: Identifiable {
    let id = UUID()
    let quarter: String
    let revenue: Int
    let profit: Int
    let operatingExpenses: Int
    let cash: Int
    let freeCashFlow: Int
    let researchAndDevelopementExpenses: Int
    let sellingGeneralAndAdministrativeExpenses: Int
    let restructuringExpenses: Int
    let automotiveRevenue: Int
    let automotiveCostOfRevenue: Int
    let automotiveRegulatoryCreditsRevenue: Int
    let automotiveLeasingRevenue: Int
    let automotiveLeasingCostOfRevenue: Int
    let serviceRevenue: Int
    let serviceCostOfRevenue: Int
    let energyRevenue: Int
    let energyCostOfRevenue: Int
    let energyStorage: Int
    let energyStorageAccumulated: Int
    let deliveredCars: Int
    let producedCars: Int
    let deliveredModel3Y: Int
    let deliveredOtherModels: Int
    let producedModel3Y: Int
    let producedOtherModels: Int
    let deliveredCarsAccumulated: Int
    let producedCarsAccumulated: Int
    let deliveredModel3YAccumulated: Int
    let deliveredOtherModelsAccumulated: Int
    let producedModel3YAccumulated: Int
    let producedOtherModelsAccumulated: Int
    let solarDeployed: Int
    let solarDeployedAccumulated: Int
    let superchargerStations: Int
    let superchargerConnectors: Int
    let superchargerStationsAccumulated: Int
    let superchargerConnectorsAccumulated: Int
    var margin: Double { Double(profit) * 100 / Double(revenue) } // in percent
    var operatingMargin: Double { Double(profit - operatingExpenses) * 100 / Double(revenue) } // in percent
    var automotiveProfit: Int { automotiveRevenue - automotiveCostOfRevenue }
    var automotiveMargin: Double { Double(automotiveProfit) * 100 / Double(automotiveRevenue) } // in percent
    var automotiveLeasingProfit: Int { automotiveLeasingRevenue - automotiveLeasingCostOfRevenue }
    var automotiveLeasingMargin: Double { Double(automotiveLeasingProfit) * 100 / Double(automotiveLeasingRevenue) } // in percent
    var energyProfit: Int { energyRevenue - energyCostOfRevenue }
    var energyMargin: Double { Double(energyProfit) * 100 / Double(energyRevenue) } // in percent
    var serviceProfit: Int { serviceRevenue - serviceCostOfRevenue }
    var serviceMargin: Double { Double(serviceProfit) * 100 / Double(serviceRevenue) } // in percent
    var automotiveCostOfGoodsSold: Int { Int(Double(automotiveCostOfRevenue) / Double(producedCars)) }
    var energyCostOfGoodsSold: Int { Int(Double(energyCostOfRevenue) / Double(energyStorage)) }
    
    var date: Date {
        // Convert quarter string to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Q'q yyyy"
        return dateFormatter.date(from: quarter) ?? Date()
    }
}

struct ChinaSalesApiDataModel: Codable {
    var units: [String: Int] // weekly insured units
}

struct ChinaWeeklySalesData: Identifiable {
    let id = UUID()
    let week: Int
    let year: Int
    let units: Int
    var date: Date {
        return dateFrom(weekNumber: week, year: year) ?? Date()
    }

    private func dateFrom(weekNumber: Int, year: Int) -> Date? {
        var components = DateComponents()
        components.weekOfYear = weekNumber
        components.yearForWeekOfYear = year
        components.weekday = 1 // 1 = Sunday, 2 = Monday, ...
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components)
    }
}
