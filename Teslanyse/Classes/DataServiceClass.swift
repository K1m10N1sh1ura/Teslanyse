//
//  DataServiceClass.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 13.03.24.
//

import Foundation

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
