//
//  SportViewModelTest.swift
//  SportinGTests
//
//  Created by Rawan Elsayed on 25/05/2024.
//

import XCTest
@testable import SportinG
import CoreData

final class SportViewModelTests: XCTestCase{
    
    var sportViewModel: SportViewModel!
    var coreDataManagerMock: CoreDataManagerMock!
    var coreDataManager: CoreDataManager!
    
    override func setUpWithError() throws {
        coreDataManagerMock = CoreDataManagerMock()
        sportViewModel = SportViewModel()
        sportViewModel.dataManager = coreDataManagerMock
        
        coreDataManager = CoreDataManager()
                
        coreDataManager.saveToCoreData(leagueKey: "1", leagueName: "League 1", leagueLogo: "logo1.png", sportName: "Football")
        coreDataManager.saveToCoreData(leagueKey: "2", leagueName: "League 2", leagueLogo: "logo2.png", sportName: "Basketball")
    }

    override func tearDownWithError() throws {
        coreDataManagerMock = nil
        sportViewModel = nil
        coreDataManager = nil
        super.tearDown()
    }
    
    func testInsertFavoriteLeague() {
        let leagueKey = "testLeagueKey"
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportName = "Test Sport"
        
        sportViewModel.insertFavoriteLeague(leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)
        
        XCTAssertTrue(coreDataManagerMock.saveToCoreDataCalled, "saveToCoreData should be called")
        XCTAssertEqual(coreDataManagerMock.savedLeagueKey, leagueKey, "Saved league key should match")
        XCTAssertEqual(coreDataManagerMock.savedLeagueName, leagueName, "Saved league name should match")
        XCTAssertEqual(coreDataManagerMock.savedLeagueLogo, leagueLogo, "Saved league logo should match")
        XCTAssertEqual(coreDataManagerMock.savedSportName, sportName, "Saved sport name should match")
    }
    
    func testDeleteFavoriteLeague() {
        let leagueKey = "testLeagueKey"
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportName = "Test Sport"
        sportViewModel.insertFavoriteLeague(leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)

        sportViewModel.deleteFavoriteLeague(leagueKey: leagueKey)
        
        XCTAssertFalse(sportViewModel.isLeagueInFavorites(leagueKey: leagueKey), "League should not be in favorites after deletion")
    }
    
    func testGetFavoriteLeagues() {
        let favoriteLeagues = sportViewModel.getFavoriteLeagues()
        
        XCTAssertNotNil(favoriteLeagues, "Favorite leagues should not be nil")
        
        for league in favoriteLeagues {
            XCTAssertNotNil(league.value(forKey: "leagueKey"), "League key should not be nil")
            XCTAssertNotNil(league.value(forKey: "leagueName"), "League name should not be nil")
            XCTAssertNotNil(league.value(forKey: "leagueLogo"), "League logo should not be nil")
            XCTAssertNotNil(league.value(forKey: "sportName"), "Sport name should not be nil")
        }
    }
    
    func testIsLeagueInFavorites() {
        XCTAssertTrue(sportViewModel.isLeagueInFavorites(leagueKey: "1"), "League should be in favorites")
    }
    
}

class CoreDataManagerMock: CoreDataManager {
    var saveToCoreDataCalled = false
    var savedLeagueKey: String?
    var savedLeagueName: String?
    var savedLeagueLogo: String?
    var savedSportName: String?
    
    override func saveToCoreData(leagueKey: String, leagueName: String, leagueLogo: String, sportName: String) {
        saveToCoreDataCalled = true
        savedLeagueKey = leagueKey
        savedLeagueName = leagueName
        savedLeagueLogo = leagueLogo
        savedSportName = sportName
    }
    
}


