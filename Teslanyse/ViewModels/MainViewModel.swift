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
            let deliveriesModel3Y = dataDictionary.deliveredModel3Y[String(i)]!
            let deliveriesOtherModels = dataDictionary.deliveredOtherModels[String(i)]!
            let productionModel3Y = dataDictionary.producedModel3Y[String(i)]!
            let productionOtherModels = dataDictionary.producedOtherModels[String(i)]!
            let solarDeployed = dataDictionary.solarDeployed[String(i)]!
            let superchargerStations = dataDictionary.superchargerStationsAccumulated[String(i)]! - (dataDictionary.superchargerStationsAccumulated[String(i - 1)] ?? 0)
            let superchargerConnectors = dataDictionary.superchargerConnectorsAccumulated[String(i)]! - (dataDictionary.superchargerConnectorsAccumulated[String(i - 1)] ?? 0)
            let superchargerStationsAccumulated = dataDictionary.superchargerStationsAccumulated[String(i)]!
            let superchargerConnectorsAccumulated = dataDictionary.superchargerConnectorsAccumulated[String(i)]!

            let quarterDatum = QuarterData(quarter: quarter,
                                           revenue: revenue,
                                           profit: profit,
                                           automotiveRevenue: carRevenue,
                                           automotiveCostOfRevenue: carCostOfRevenue,
                                           deliveredCars: deliveredCars,
                                           producedCars: producedCars,
                                           energyRevenue: energyRevenue,
                                           energyCostOfRevenue: energyCostOfRevenue,
                                           energyStorage: energyStorage,
                                           deliveredModel3Y: deliveriesModel3Y,
                                           deliveredOtherModels: deliveriesOtherModels,
                                           producedModel3Y: productionModel3Y,
                                           producedOtherModels: productionOtherModels,
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
        }
        return data
    }
    
}






class DataService {
    func fetchTeslaApiData() async throws -> TeslaApiDataModel {
        //let endpoint = "http://192.168.178.20:5001/tesla_earnings" // local endpoint
        let endpoint = "https://teslanyse-server-320ff9c71971.herokuapp.com/tesla_earnings" // heroku online endpoint

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(TeslaApiDataModel.self, from: data)
    }
}
