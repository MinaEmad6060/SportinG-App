//
//  MockNetworkServiceTests.swift
//  SportinGTests
//
//  Created by Mina Emad on 26/05/2024.
//

import XCTest
@testable import SportinG

final class MockNetworkServiceTests: XCTestCase {
    
    
    var network: MockNetworkService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = MockNetworkService(success: true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }


    func testGetDataFun(){
        network.getData(fromURL: "") { sportDetails in
            if sportDetails != nil{
                XCTAssertEqual(sportDetails?[0].result[0].league_name, "UEFA Europa League")
            } else{
                XCTFail()
                return
            }
           
        }
    }
    
    
    func testGetDataFromAPI(){
        network.getDataFromFakeJSON{ result in
            XCTAssertNotNil(result)
        }
    }
    

}
