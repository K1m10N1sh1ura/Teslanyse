//
//  MainViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var quarters = [QuarterData]()
    private let dataService = DataService()
    @Published var errorMessage: String?

    init() {
        Task {
            await loadData()
        }
    }
    
    func loadData() async {
        do {
            let dataDict = try await dataService.fetchTeslaApiData()
            // Assuming a method to directly convert to your desired data structure exists
            self.quarters = self.extractQuarterData(from: dataDict)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func getIndexOfQuarter(_ quarter: String) -> Int? {
        for (index, quarterObj) in quarters.enumerated() {
            if quarterObj.quarter == quarter {
                return index
            }
        }
        return nil
    }
    
    func extractQuarterData(from dataDictionary: TeslaApiDataModel) -> [QuarterData] {
        var quarterData = [QuarterData]()
        let numberOfQuarters = dataDictionary.quarter.count
        
        for i in 0..<numberOfQuarters {
            let quarter = dataDictionary.quarter[String(i)]!
            let profit = dataDictionary.profit[String(i)]!
            let revenue = dataDictionary.revenue[String(i)]!
            let carRevenue = dataDictionary.automotiveRevenue[String(i)]!
            let carCostOfRevenue = dataDictionary.automotiveCostOfRevenue[String(i)]!
            let producedCars = dataDictionary.producedCars[String(i)]!
            let deliveredCars = dataDictionary.deliveredCars[String(i)]!
            let energyRevenue = dataDictionary.energyRevenue[String(i)]!
            let energyCostOfRevenue = dataDictionary.energyCostOfRevenue[String(i)]!
            let energyStorage = dataDictionary.energyStorage[String(i)]!
            let deliveredModel3Y = dataDictionary.deliveredModel3Y[String(i)]!
            let deliveredOtherModels = dataDictionary.deliveredOtherModels[String(i)]!
            let producedModel3Y = dataDictionary.producedModel3Y[String(i)]!
            let producedOtherModels = dataDictionary.producedOtherModels[String(i)]!
            let solarDeployed = dataDictionary.solarDeployed[String(i)]!
            let superchargerStations = dataDictionary.superchargerStationsAccumulated[String(i)]! - (dataDictionary.superchargerStationsAccumulated[String(i - 1)] ?? 0)
            let superchargerConnectors = dataDictionary.superchargerConnectorsAccumulated[String(i)]! - (dataDictionary.superchargerConnectorsAccumulated[String(i - 1)] ?? 0)
            let superchargerStationsAccumulated = dataDictionary.superchargerStationsAccumulated[String(i)]!
            let superchargerConnectorsAccumulated = dataDictionary.superchargerConnectorsAccumulated[String(i)]!
            var producedCarsAccumulated: Int = 0
            var deliveredCarsAccumulated: Int = 0
            var deliveredModel3YAccumulated: Int = 0
            var deliveredOtherModelsAccumulated: Int = 0
            var producedModel3YAccumulated: Int = 0
            var producedOtherModelsAccumulated: Int = 0
            
            for n in 0...i {
                producedCarsAccumulated += dataDictionary.producedCars[String(n)]!
                deliveredCarsAccumulated += dataDictionary.deliveredCars[String(n)]!
                producedModel3YAccumulated += dataDictionary.producedModel3Y[String(n)]!
                deliveredModel3YAccumulated += dataDictionary.deliveredModel3Y[String(n)]!
                producedOtherModelsAccumulated += dataDictionary.producedOtherModels[String(n)]!
                deliveredOtherModelsAccumulated += dataDictionary.deliveredOtherModels[String(n)]!
            }


            let quarterDatum = QuarterData(quarter: quarter,
                                           revenue: revenue,
                                           profit: profit,
                                           automotiveRevenue: carRevenue,
                                           automotiveCostOfRevenue: carCostOfRevenue,
                                           energyRevenue: energyRevenue,
                                           energyCostOfRevenue: energyCostOfRevenue,
                                           energyStorage: energyStorage,
                                           deliveredCars: deliveredCars,
                                           producedCars: producedCars,
                                           deliveredModel3Y: deliveredModel3Y,
                                           deliveredOtherModels: deliveredOtherModels,
                                           producedModel3Y: producedModel3Y,
                                           producedOtherModels: producedOtherModels,
                                           deliveredCarsAccumulated: deliveredCarsAccumulated,
                                           producedCarsAccumulated: producedCarsAccumulated,
                                           deliveredModel3YAccumulated: deliveredModel3YAccumulated,
                                           deliveredOtherModelsAccumulated: deliveredOtherModelsAccumulated,
                                           producedModel3YAccumulated: producedModel3YAccumulated,
                                           producedOtherModelsAccumulated: producedOtherModelsAccumulated,
                                           solarDeployed: solarDeployed,
                                           superchargerStations: superchargerStations,
                                           superchargerConnectors: superchargerConnectors,
                                           superchargerStationsAccumulated: superchargerStationsAccumulated,
                                           superchargerConnectorsAccumulated: superchargerConnectorsAccumulated
            )
            quarterData.append(quarterDatum)
        }
        return quarterData
    }
    
    func extractQuarters () -> [Date] {
        var data = [Date]()

        for quarter in quarters {
            data.append(quarter.date)
        }
        return data
    }
    
    func extractData(property: QuarterDataEnum) -> [Double] {
        var data = [Double]()
        
        switch (property) {
        case .deliveredModel3Y:
            for quarter in quarters {
                data.append(Double(quarter.deliveredModel3Y))
            }
        case .producedModel3Y:
            for quarter in quarters {
                data.append(Double(quarter.producedModel3Y))
            }
        case .deliveredOtherModels:
            for quarter in quarters {
                data.append(Double(quarter.deliveredOtherModels))
            }
        case .producedOtherModels:
            for quarter in quarters {
                data.append(Double(quarter.producedOtherModels))
            }
        case .deliveredCars:
            for quarter in quarters {
                data.append(Double(quarter.deliveredCars))
            }
        case .producedCars:
            for quarter in quarters {
                data.append(Double(quarter.producedCars))
            }
        case .automotiveCostOfGoodsSold:
            for quarter in quarters {
                data.append(Double(quarter.automotiveCostOfGoodsSold))
            }
        case .automotiveMargin:
            for quarter in quarters {
                data.append(quarter.automotiveMargin)
            }
        case .automotiveProfit:
            for quarter in quarters {
                data.append(Double(quarter.automotiveProfit))
            }
        case .automotiveCostOfRevenue:
            for quarter in quarters {
                data.append(Double(quarter.automotiveCostOfRevenue))
            }
        case .automotiveRevenue:
            for quarter in quarters {
                data.append(Double(quarter.automotiveRevenue))
            }
        case .energyCostOfGoodsSold:
            for quarter in quarters {
                data.append(Double(quarter.energyCostOfGoodsSold))
            }
        case .energyCostOfRevenue:
            for quarter in quarters {
                data.append(Double(quarter.energyCostOfRevenue))
            }
        case .energyMargin:
            for quarter in quarters {
                data.append(quarter.energyMargin)
            }
        case .energyProfit:
            for quarter in quarters {
                data.append(Double(quarter.energyProfit))
            }
        case .energyStorage:
            for quarter in quarters {
                data.append(Double(quarter.energyStorage))
            }
        case .margin:
            for quarter in quarters {
                data.append(quarter.margin)
            }
        case .profit:
            for quarter in quarters {
                data.append(Double(quarter.profit))
            }
        case .revenue:
            for quarter in quarters {
                data.append(Double(quarter.revenue))
            }
        case .energyRevenue:
            for quarter in quarters {
                data.append(Double(quarter.energyRevenue))
            }
        case .solarDeployed:
            for quarter in quarters {
                data.append(Double(quarter.solarDeployed))
            }
        case .superchargerStations:
            for quarter in quarters {
                data.append(Double(quarter.superchargerStations))
            }
        case .superchargerConnectors:
            for quarter in quarters {
                data.append(Double(quarter.superchargerConnectors))
            }
        case .superchargerStationsAccumulated:
            for quarter in quarters {
                data.append(Double(quarter.superchargerStationsAccumulated))
            }
        case .superchargerConnectorsAccumulated:
            for quarter in quarters {
                data.append(Double(quarter.superchargerConnectorsAccumulated))
            }
        case .deliveredCarsAccumulated:
            for quarter in quarters {
                data.append(Double(quarter.deliveredCarsAccumulated))
            }
        case .producedCarsAccumulated:
            for quarter in quarters {
                data.append(Double(quarter.producedCarsAccumulated))
            }
        case .deliveredModel3YAccumulated:
            for quarter in quarters {
                data.append(Double(quarter.deliveredModel3YAccumulated))
            }
        case .deliveredOtherModelsAccumulated:
            for quarter in quarters {
                data.append(Double(quarter.deliveredOtherModelsAccumulated))
            }
        case .producedModel3YAccumulated:
            for quarter in quarters {
                data.append(Double(quarter.producedModel3YAccumulated))
            }
        case .producedOtherModelsAccumulated:
            for quarter in quarters {
                data.append(Double(quarter.producedOtherModelsAccumulated))
            }
        }
        return data
    }
    
}







