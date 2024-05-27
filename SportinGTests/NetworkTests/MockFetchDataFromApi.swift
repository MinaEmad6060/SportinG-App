//
//  MockFetchDataFromApi.swift
//  SportinGTests
//
//  Created by Mina Emad on 26/05/2024.
//

import Foundation
@testable import SportinG

class MockNetworkService {
    var success: Bool
    
    enum ResponseWithError: Error {
        case responseError
    }
    
    var listOfSports = SportDetails(result: [])
    var sports: [SportDetails] = []
    var sport: SportDetails?
    var result: Result?
    
    var sportsJSON: [String: Any] = [
        "result": [
            [
                "league_key": 4,
                "league_name": "UEFA Europa League",
                "country_key": 1,
                "country_name": "eurocups"
            ]
        ]
    ]
    
    init(success: Bool) {
        self.success = success
        sport = SportDetails(result: [])
        result = Result(league_name: "UEFA Europa League")
        sport?.result.append(result!)
        sports.append(sport!)
    }
    
    func getData(fromURL: String, handler: @escaping ([SportDetails]?) -> Void) {
        // Simulating a network request by directly returning the mock data based on the success flag
        if success {
            handler(sports)
        } else {
            handler(nil)
        }
    }
    
    func getDataFromFakeJSON(handler: @escaping (SportDetails?) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: sportsJSON)
            listOfSports = try JSONDecoder().decode(SportDetails.self, from: jsonData)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        if success {
            handler(listOfSports)
        } else {
            handler(nil)
        }
    }
}
