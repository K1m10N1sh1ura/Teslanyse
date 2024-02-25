//
//  PlotDataViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 24.02.24.
//

import Foundation

class PlotDataViewModel: ObservableObject {
    
    @Published var teslaData: TeslaDataModel? = TeslaDataModel()
    
    init() {
        Task {
            self.teslaData = try? await fetchData()
            print(teslaData)
        }
    }
    
    func fetchData() async throws -> TeslaDataModel? {
        let endpoint = "http://127.0.0.1:5000/quartalszahlen"
        guard let url = URL(string: endpoint) else {
            print("[ERRoR] invalid url")
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
