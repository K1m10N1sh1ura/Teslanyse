//
//  DataServiceClass.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 13.03.24.
//

import Foundation

protocol DataServiceProtocol {
    associatedtype T
    func fetchData(endpoint: String) async throws -> T
}

class DataService<T: Decodable>: DataServiceProtocol {
    func fetchData(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

struct EndpointManager {
    static let baseLocalURL = "http://192.168.178.20:5001"
    static let baseHerokuURL = "https://teslanyse-server-320ff9c71971.herokuapp.com"
    
    static var teslaEarnings: String {
        return "\(baseLocalURL)/tesla_earnings" // Switch to baseHerokuURL if needed
    }
    
    static func chinaWeeklySales(forYear year: String) -> String {
        return "\(baseLocalURL)/china_weekly_sales/\(year)" // Switch to baseHerokuURL if needed
    }
}
