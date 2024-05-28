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
    
    
    
    //Network service
    
    func testSetSportUrl(){
        
        var result: (String, String)!
        
        
        result=sportViewModel.setSportUrl(selectedSport: 0)
        
        XCTAssertEqual(result.1, "football", "The team name should be 'football'")
        
        result=sportViewModel.setSportUrl(selectedSport: 1)

        XCTAssertEqual(result.1, "basketball", "The team name should be 'football'")
        
        result=sportViewModel.setSportUrl(selectedSport: 2)

        XCTAssertEqual(result.1, "cricket", "The team name should be 'football'")
        
        result=sportViewModel.setSportUrl(selectedSport: 3)

        XCTAssertEqual(result.1, "tennis", "The team name should be 'football'")

        result=sportViewModel.setSportUrl(selectedSport: 4)

        XCTAssertEqual(result.1, "", "The team name should be 'football'")

    }
   
    
    func testLeaguesFormatedUrl(){
        let url = sportViewModel?.getLeaguesFormatedUrl(sport: "football", met: "Fixtures",leaguesKies: [141],index: 0)
        
        XCTAssertEqual(url, "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=141&teamId=")
    }
  
    
    func testGetLatestDetailsFromNetworkService() {
        let expectation = self.expectation(description: "Wait for fetching data ..")
        let url = "https://apiv2.allsportsapi.com/football?met=Fixtures&from=2023-05-29&to=2024-05-29&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=141"

        sportViewModel.getLatestDetailsFromNetworkService(url: url)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.sportViewModel.leagueLatestDetails, "leagueTeamsDetails should not be nil")
            if let leagueTeamsDetails = self.sportViewModel.leagueTeamsDetails {
                XCTAssertEqual(leagueTeamsDetails.result.first?.event_home_team, "Pyramids", "The team name should be 'Pyramids'")
                XCTAssertEqual(leagueTeamsDetails.result.first?.event_away_team, "El Gouna", "The team name should be 'El Gouna'")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testGetUpcomingEventsFromNetworkService() {
        let expectation = self.expectation(description: "Wait for fetching data ..")
        let url = "https://apiv2.allsportsapi.com/football?met=Fixtures&from=2024-05-29&to=2025-05-29&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=141"

        sportViewModel.getSportLeaguesDetailsFromNetworkService(url: url)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.sportViewModel.leaguesUpcomingDetails, "leagueTeamsDetails should not be nil")
            if let leagueTeamsDetails = self.sportViewModel.leagueTeamsDetails {
                XCTAssertEqual(leagueTeamsDetails.result.first?.event_home_team, "Al Ahly", "The team name should be 'Al Ahly'")
                XCTAssertEqual(leagueTeamsDetails.result.first?.event_away_team, "Pyramids", "The team name should be 'Pyramids'")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    
    func testGetTeamsLogosFromNetworkService() {
        let expectation = self.expectation(description: "Wait for fetching data ..")
        let url = "https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=141"
                
        sportViewModel.getTeamsLogosFromNetworkService(url: url)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.sportViewModel.leagueTeamsLogos, "leagueTeamsDetails should not be nil")
            if let leagueTeamsDetails = self.sportViewModel.leagueTeamsDetails {
                XCTAssertEqual(leagueTeamsDetails.result.first?.team_logo, "https://apiv2.allsportsapi.com/logo/585_al-ahly.jpg", "The team name should be 'https://apiv2.allsportsapi.com/logo/585_al-ahly.jpg'")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetTeamsDetailsFromNetworkService() {
        let expectation = self.expectation(description: "Wait for fetching data ..")
        let url = "https://apiv2.allsportsapi.com/football/?met=Teams&teamId=152&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
                
        sportViewModel.getTeamsDetailsFromNetworkService(url: url)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.sportViewModel.leagueTeamsDetails, "leagueTeamsDetails should not be nil")
            if let leagueTeamsDetails = self.sportViewModel.leagueTeamsDetails {
                XCTAssertEqual(leagueTeamsDetails.result.first?.team_name, "Napoli", "The team name should be 'Napoli'")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
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


