//
//  NetworkTests.swift
//  SportinGTests
//
//  Created by Mina Emad on 26/05/2024.
//

import XCTest
@testable import SportinG

final class NetworkTests: XCTestCase {

    
    var fetchDataFromApi: FetchDataFromApi?
    var url: String!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fetchDataFromApi = FetchDataFromApi()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        fetchDataFromApi = nil
    }
    
//    func formatURL(sport: String, met: String, teamId: String="", leagueId: String="") -> String{
//        return baseUrl+sport+"/?met="+met+"&APIkey="+apiKey+"&leagueId="+leagueId+"&teamId="+teamId
//    }
    
    func testFormatUrl(){
        url = fetchDataFromApi?.formatURL(sport: "football", met: "Leagues",teamId: "",leagueId: "")
        
        XCTAssertEqual(url, "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=&teamId=")
    }

    
    func testFetchDataFromApi(){
        let expectation = expectation(description: "Wait for fetching data ..")
        let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"
        
        fetchDataFromApi?.getSportData(url: url){listOfUsers in
       
            XCTAssertEqual(listOfUsers.result.count, 865)
            print("Count Of users : \(listOfUsers.result.count)")
            
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 3)
    }
    
}
