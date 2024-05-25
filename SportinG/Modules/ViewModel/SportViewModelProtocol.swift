//
//  SportViewModelProtocol.swift
//  SportinG
//
//  Created by Rawan Elsayed on 24/05/2024.
//

import Foundation
import CoreData

protocol SportViewModelProtocol{
    
    func retrieveFavoriteLeagues()
    func deleteFavoriteLeague(leagueKey: String)
    func insertFavoriteLeague(leagueKey: String, leagueName: String, leagueLogo: String, sportName: String)
    func isLeagueInFavorites(leagueKey: String) -> Bool
    func getFavoriteLeagues() -> [NSManagedObject]
    
}
