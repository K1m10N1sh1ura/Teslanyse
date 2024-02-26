//
//  TeslaDataModel.swift
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
    var carCostOfRevenue: [String:Int] = [:]
    var carNumCars: [String:Int] = [:]
    var energyRevenue: [String:Int] = [:]
    var energyCostOfRevenue: [String:Int] = [:]
    var energyStorage: [String:Int] = [:]
}
