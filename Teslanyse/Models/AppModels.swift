//
//  AppModels.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import Foundation

struct TeslaApiDataModel: Codable {
    var quarter: [String:String] = [:]
    var profit: [String:Int] = [:]
    var revenue: [String:Int] = [:]
    // automotive
    var automotiveRevenue: [String:Int] = [:]
    var automotiveCostOfRevenue: [String:Int] = [:]
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
    // superchargers
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
    let superchargerStations: Int
    let superchargerConnectors: Int
    let superchargerStationsAccumulated: Int
    let superchargerConnectorsAccumulated: Int
    var margin: Double { Double(profit) / Double(revenue) }
    var automotiveProfit: Int { automotiveRevenue - automotiveCostOfRevenue }
    var automotiveMargin: Double { Double(automotiveProfit) / Double(automotiveRevenue) }
    var energyProfit: Int { energyRevenue - energyCostOfRevenue }
    var energyMargin: Double { Double(energyProfit) / Double(energyRevenue) }
    var automotiveCostOfGoodsSold: Int { Int(Double(automotiveCostOfRevenue) / Double(producedCars)) }
    var energyCostOfGoodsSold: Int { Int(Double(energyCostOfRevenue) / Double(energyStorage)) }
    var date: Date {
        // Convert quarter string to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Q'q yyyy"
        return dateFormatter.date(from: quarter) ?? Date()
    }
}
