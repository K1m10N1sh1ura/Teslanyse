//
//  AppModels.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import Foundation

struct TeslaDataModel: Codable {
    var quarter: [String:String] = [:]
    var profit: [String:Int] = [:]
    var revenue: [String:Int] = [:]
    var carRevenue: [String:Int] = [:]
    var deliveredModel3Y: [String:Int] = [:]
    var deliveredOtherModels: [String:Int] = [:]
    var producedModel3Y: [String:Int] = [:]
    var producedOtherModels: [String:Int] = [:]
    var deliveredCars: [String:Int] = [:]
    var producedCars: [String:Int] = [:]
    var energyRevenue: [String:Int] = [:]
    var carCostOfRevenue: [String:Int] = [:]
    var energyCostOfRevenue: [String:Int] = [:]
    var energyStorage: [String:Int] = [:]
}

struct QuarterData: Identifiable {
    let id = UUID()
    let quarter: String
    let revenue: Int
    let profit: Int
    let carRevenue: Int
    let carCostOfRevenue: Int
    let deliveredCars: Int
    let producedCars: Int
    let energyRevenue: Int
    let energyCostOfRevenue: Int
    let energyStorage: Int
    let deliveredModel3Y: Int
    let deliveredOtherModels: Int
    let producedModel3Y: Int
    let producedOtherModels: Int
    
    var margin: Double {
        return Double(profit) / Double(revenue)
    }
    
    var date: Date {
        // Convert quarter string to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Q'q yyyy"
        return dateFormatter.date(from: quarter) ?? Date()
    }
    
}

enum TeslaModel {
    case model3Y
    case otherModels
}

enum TeslaSaleState {
    case produced
    case delivered
}
