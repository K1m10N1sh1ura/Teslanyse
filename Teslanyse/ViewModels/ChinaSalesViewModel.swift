//
//  ChinaSalesViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 14.03.24.
//

import Foundation

class ChinaSalesViewModel: ObservableObject {
    @Published var weeks = [ChinaWeeklySalesData]()
    @Published var errorMessage: String?
    private var dataService: DataService<ChinaSalesApiDataModel>
    
    init(dataService: DataService<ChinaSalesApiDataModel>) {
        self.dataService = dataService
        Task {
            let yearsPath = ["2022", "2023", "2024"]
            await withTaskGroup(of: Void.self) { group in
                for year in yearsPath {
                    group.addTask {
                        await self.loadData(endpoint: EndpointManager.chinaWeeklySales(forYear: year), year: year)
                    }
                }
            }
        }
    }
    
    func loadData(endpoint: String, year: String) async {
        do {
            let dataDict = try await dataService.fetchData(endpoint: endpoint)
            self.weeks.append(contentsOf: extractWeeklyData(from: dataDict, year: Int(year) ?? 0))
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func extractWeeklyData(from dataDictionary: ChinaSalesApiDataModel, year: Int) -> [ChinaWeeklySalesData] {
        var weeklyData = [ChinaWeeklySalesData]()
        let numberOfWeeks = dataDictionary.units.count
        for week in 0..<numberOfWeeks {
            
            let units = dataDictionary.units[String(week)]!
            let week = week
            let year = year

            let weeklyDatum = ChinaWeeklySalesData(week: week, year: year, units: units)
            weeklyData.append(weeklyDatum)
        }
        return weeklyData
    }
    
    func extractWeeks () -> [Date] {
        var data = [Date]()

        for week in weeks {
            data.append(week.date)
        }
        return data
    }
    
    func extractData(property: ChinaWeeklySalesDataEnum) -> [Int] {
        var data = [Int]()
        
        switch (property) {
        case .units:
            for week in weeks {
                data.append(week.units)
            }
        }
        return data
    }

}
