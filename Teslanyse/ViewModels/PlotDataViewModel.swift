//
//  PlotDataViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import Foundation

class PlotDataViewModel: ObservableObject {
    
    @Published var quarters = [QuarterData]()
    
    init() {
        Task {
            guard let dataDict = try? await fetchData() else {
                return
            }
            DispatchQueue.main.async {
                self.quarters = self.extractQuarterData(from: dataDict)
            }
        }
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
    
    func fetchData() async throws -> TeslaApiDataModel? {
        let endpoint = "http://192.168.178.20:5001/tesla_earnings"
        guard let url = URL(string: endpoint) else {
            print("[ERROR] invalid url")
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
                print("[ERROR] Invalid response")
                return nil
            }

            guard let jsonData = try? JSONDecoder().decode(TeslaApiDataModel.self, from: data) else {
                print("[ERROR] failed decoding json data")
                return nil
            }
            return jsonData
        }
        catch {
            print("[ERROR] An error occured while trying to fetch data: \(error.localizedDescription)")
        }
        return nil
    }
    
}
