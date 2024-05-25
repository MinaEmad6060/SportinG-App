//
//  SportViewModelProtocol.swift
//  SportinG
//
//  Created by Rawan Elsayed on 24/05/2024.
//

import Foundation

protocol SportViewModelProtocol{
    var bindUpcomingToViewController: (() -> ())? { get set }
    var bindLatestToViewController: (() -> ())? { get set }
    var bindLogosToViewController: (() -> ())? { get set }
    var leaguesUpcomingDetails: SportDetails? { get set }
    var leagueLatestDetails: SportDetails? { get set }
    var leagueTeamsLogos: SportDetails? { get set }
    func setSportUrl(selectedSport: Int) -> (String, String)
    func getSportLeaguesFromNetworkService(url: String)
    func getLeaguesFormatedUrl(sport: String, met:String, leaguesKies: [Int], index: Int) -> String
    func getTeamsDetailsFormatedUrl(sport: String, met: String, teamId: String) -> String
    func getLeagueDetailsFromNetworkService(url: String)
    func getLatestDetailsFromNetworkService(url: String)
    func getTeamsDetailsFromNetworkService(url: String)
}
