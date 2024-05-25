//
//  SportViewModel.swift
//  SportinG
//
//  Created by Rawan Elsayed on 24/05/2024.
//

import Foundation
import CoreData
import UIKit

class SportViewModel: SportViewModelProtocol{
    
    let dataManager = CoreDataManager()
    var favoriteLeagues: [NSManagedObject] = []
    var sportDetails = SportDetails()
    
    func retrieveFavoriteLeagues() {
        if let leagues = dataManager.retrieveFromCoreData() {
            favoriteLeagues = leagues
        }
    }
    
    func deleteFavoriteLeague(leagueKey: String) {
        dataManager.deleteFromCoreData(leagueKey: leagueKey)
        favoriteLeagues = favoriteLeagues.filter { ($0.value(forKey: "leagueKey") as? String) != leagueKey }
    }
    
    func insertFavoriteLeague(leagueKey: String, leagueName: String, leagueLogo: String, sportName: String) {
        if !dataManager.leagueExistsInCoreData(leagueKey: leagueKey) {
            dataManager.saveToCoreData(leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)
            print("League added to favorites!")
        } else {
            print("League already exists in favorites!")
        }
    }
    
    func isLeagueInFavorites(leagueKey: String) -> Bool {
        return dataManager.leagueExistsInCoreData(leagueKey: leagueKey)
    }
    
    func getFavoriteLeagues() -> [NSManagedObject] {
        return favoriteLeagues
    }
    
}
