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
            quarters = extractQuarterData(from: dataDict)
        }
    }
    
    func extractQuarterData(from dataDictionary: TeslaDataModel) -> [QuarterData] {
        var quarterData = [QuarterData]()
        let numberOfQuarters = dataDictionary.quarter.count
        
        for i in 0..<numberOfQuarters {
            let quarter = dataDictionary.quarter[String(i)]!
            let profit = dataDictionary.profit[String(i)]!
            let revenue = dataDictionary.revenue[String(i)]!
            let carRevenue = dataDictionary.carRevenue[String(i)]!
            let carCostOfRevenue = dataDictionary.carCostOfRevenue[String(i)]!
            let producedCars = dataDictionary.producedCars[String(i)]!
            let deliveredCars = dataDictionary.deliveredCars[String(i)]!
            let energyRevenue = dataDictionary.energyRevenue[String(i)]!
            let energyCostOfRevenue = dataDictionary.energyCostOfRevenue[String(i)]!
            let energyStorage = dataDictionary.energyStorage[String(i)]!
            let deliveriesModel3Y = dataDictionary.deliveredModel3Y[String(i)]!
            let deliveriesOtherModels = dataDictionary.deliveredOtherModels[String(i)]!
            let productionModel3Y = dataDictionary.producedModel3Y[String(i)]!
            let productionOtherModels = dataDictionary.producedOtherModels[String(i)]!

            let quarterDatum = QuarterData(quarter: quarter,
                                           revenue: revenue,
                                           profit: profit,
                                           carRevenue: carRevenue,
                                           carCostOfRevenue: carCostOfRevenue,
                                           deliveredCars: deliveredCars,
                                           producedCars: producedCars,
                                           energyRevenue: energyRevenue,
                                           energyCostOfRevenue: energyCostOfRevenue,
                                           energyStorage: energyStorage,
                                           deliveredModel3Y: deliveriesModel3Y,
                                           deliveredOtherModels: deliveriesOtherModels,
                                           producedModel3Y: productionModel3Y,
                                           producedOtherModels: productionOtherModels)
                                          
            
            quarterData.append(quarterDatum)
        }
        return quarterData
    }
    
    func fetchData() async throws -> TeslaDataModel? {
        let endpoint = "http://127.0.0.1:5000/quartalszahlen"
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

            guard let jsonData = try? JSONDecoder().decode(TeslaDataModel.self, from: data) else {
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
