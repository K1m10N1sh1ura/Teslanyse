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
                print("[Error] Data dict seems to be empty")
                return
            }
            quarters = extractQuarterData(from: dataDict)
            for quarter in quarters {
                print(quarter.margin)
            }
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
            let carNumCars = dataDictionary.carNumCars[String(i)]!
            let energyRevenue = dataDictionary.energyRevenue[String(i)]!
            let energyCostOfRevenue = dataDictionary.energyCostOfRevenue[String(i)]!
            let energyStorage = dataDictionary.energyStorage[String(i)]!

            let quarterDatum = QuarterData(quarter: quarter,
                                          revenue: revenue,
                                          profit: profit,
                                          carRevenue: carRevenue,
                                          carCostOfRevenue: carCostOfRevenue,
                                          carNumCars: carNumCars,
                                          energyRevenue: energyRevenue,
                                          energyCostOfRevenue: energyCostOfRevenue,
                                          energyStorage: energyStorage)
            
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