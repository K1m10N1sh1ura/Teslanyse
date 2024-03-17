//
//  WeekDataViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 14.03.24.
//

import Foundation

class WeekDataViewModel: ObservableObject {
    @Published var weeks = [ChinaWeeklySalesData]()
    @Published var errorMessage: String?
    @Published var dataLoaded = false
    private var dataService: DataService<ChinaSalesApiDataModel>
    var dates: [Date] {
        return weeks.map { $0.date }
    }
    
    init(dataService: DataService<ChinaSalesApiDataModel>) {
        self.dataService = dataService
        Task {
            let yearsPath = ["2022", "2023", "2024"]
            
            for year in yearsPath {
                // Execute each load task and wait for it to complete before continuing to the next iteration.
                await loadData(endpoint: EndpointManager.chinaWeeklySales(forYear: year), year: year)
            }
            dataLoaded = true
        }
    }
    
    func getIndexOfWeek(_ week: String) -> Int? {
        return weeks.firstIndex { $0.week == Int(week) }
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
