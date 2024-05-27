//
//  CoreDataManagerTest.swift
//  SportinGTests
//
//  Created by Rawan Elsayed on 26/05/2024.
//

import XCTest
@testable import SportinG

final class CoreDataManagerTest: XCTestCase{
    
    var coreDataManager : CoreDataManager!
    var testLeagueKey: String!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManager()
        testLeagueKey = "testLeagueKey"
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        testLeagueKey = nil
    }

    
    func testSaveLeagueToCoreData() {
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportName = "Test Sport"
        
        coreDataManager.saveToCoreData(leagueKey: testLeagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)
        
        XCTAssertTrue(coreDataManager.leagueExistsInCoreData(leagueKey: testLeagueKey), "League should exist in Core Data after saving")
    }
    
    func testDeleteLeagueFromCoreData() {
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportName = "Test Sport"
        coreDataManager.saveToCoreData(leagueKey: testLeagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)
        
        coreDataManager.deleteFromCoreData(leagueKey: testLeagueKey)
        
        XCTAssertFalse(coreDataManager.leagueExistsInCoreData(leagueKey: testLeagueKey), "League should not exist in Core Data after deletion")
    }
    
    func testRetrieveFromCoreData() {
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportName = "Test Sport"
        coreDataManager.saveToCoreData(leagueKey: testLeagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)
        
        let retrievedLeagues = coreDataManager.retrieveFromCoreData()
        
        XCTAssertNotNil(retrievedLeagues, "Retrieved leagues should not be nil")

    }
    
    func testLeagueExistsInCoreData() {
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportName = "Test Sport"
        coreDataManager.saveToCoreData(leagueKey: testLeagueKey, leagueName: leagueName, leagueLogo: leagueLogo, sportName: sportName)
        
        let exists = coreDataManager.leagueExistsInCoreData(leagueKey: testLeagueKey)
        
        XCTAssertTrue(exists, "League should exist in Core Data")
    }
    
}
