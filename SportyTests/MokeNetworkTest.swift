//
//  MokeNetworkTest.swift
//  SportyTests
//
//  Created by ahmed on 28/05/2023.
//

import XCTest
@testable import Sporty
final class MokeNetworkTest: XCTestCase {
    var networkManager : NetworkProtocol?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testLoadDataFromURLShouldPassAndParsingitInLeagues(){
        networkManager = MockNetwork(shouldReturnError: false)
        networkManager?.getCountryData(sport: "football", compilation: { listLeag, error in
            guard let listLeag  = listLeag else{
                XCTFail()
                return
            }
            XCTAssertGreaterThan(listLeag.count, 0, "API Faild")
        })
        
    }
    func testLoadDataFromURLShouldPassAndParsingitInComingEvents(){
        networkManager = MockNetwork(shouldReturnError: false)
        networkManager?.getComingEvent(sport: "football", fromDate: "", toDate: "", leagueid: "", compilation: { listComeEvent, error in
            guard let listComeEvent  = listComeEvent else{
                XCTFail()
                return
            }
            XCTAssertGreaterThan(listComeEvent.count, 0, "API Faild")
        })
        
    }
    func testLoadDataFromURLShouldPassAndParsingitInTeams(){
        networkManager = MockNetwork(shouldReturnError: false)
        networkManager?.getTeams(sport: "", leagueid: "", compilation: { listTeamData, error in
            guard let listTeamData = listTeamData else{
                XCTFail()
                return
            }
            XCTAssertGreaterThan(listTeamData.count, 0, "API Faild")
            
        })
        
    }
    func testLoadDataFromURLShouldFailLeagues(){
        networkManager = MockNetwork(shouldReturnError: true)
        networkManager?.getCountryData(sport: "football", compilation: { leags, erro in
            XCTAssertNil(leags, "Items Not nil")
        })
        
    }
    func testLoadDataFromURLShouldFailEvents(){
        networkManager = MockNetwork(shouldReturnError: true)
        networkManager?.getComingEvent(sport: "football", fromDate: "", toDate: "", leagueid: "", compilation: { comeEvent, error in
            XCTAssertNil(comeEvent, "Items Not nil")
        })
        
    }
    func testLoadDataFromURLShouldFailTeams(){
        networkManager = MockNetwork(shouldReturnError: true)
        networkManager?.getTeams(sport: "football", leagueid: "", compilation: { teams, error in
            XCTAssertNil(teams, "Items Not nil")
            
        })
        
    }
    func testDecodingLeaguesFails(){
        networkManager = MockNetwork(shouldReturnError: false)
        Utilites.leagueMockItemsJSONResponse = """
                                        "menu": {
                                          "id": "file",
                                          "value": "File",
                                          "popup": {
                                            "menuitem": [
                                              {"value": "New", "onclick": "CreateNewDoc()"},
                                              {"value": "Open", "onclick": "OpenDoc()"},
                                              {"value": "Close", "onclick": "CloseDoc()"}
                                            ]
                                          }
                                        }}
"""
        networkManager?.getCountryData(sport: "football", compilation: { leagues, error in
            guard let leagues = leagues else{
                XCTAssertNil(leagues, "Items Not nil")
                return
            }
        })
        
        
        
    }
    func testDecodingComeEventsFails(){
        networkManager = MockNetwork(shouldReturnError: false)
        Utilites.comeEventsMockItemsJSONResponse = """
                                        "menu": {
                                          "id": "file",
                                          "value": "File",
                                          "popup": {
                                            "menuitem": [
                                              {"value": "New", "onclick": "CreateNewDoc()"},
                                              {"value": "Open", "onclick": "OpenDoc()"},
                                              {"value": "Close", "onclick": "CloseDoc()"}
                                            ]
                                          }
                                        }}
"""
        networkManager?.getComingEvent(sport: "", fromDate: "", toDate: "", leagueid: "", compilation: { comeEvents, error in
            guard let comeEvents = comeEvents else{
                XCTAssertNil(comeEvents, "Items Not nil")
                return
            }
        })
        
        
    }
    func testDecodingTeamsFails(){
        networkManager = MockNetwork(shouldReturnError: false)
        Utilites.teamsMockItemsJSONResponse = """
                                        "menu": {
                                          "id": "file",
                                          "value": "File",
                                          "popup": {
                                            "menuitem": [
                                              {"value": "New", "onclick": "CreateNewDoc()"},
                                              {"value": "Open", "onclick": "OpenDoc()"},
                                              {"value": "Close", "onclick": "CloseDoc()"}
                                            ]
                                          }
                                        }}
"""
        networkManager?.getTeams(sport: "", leagueid: "", compilation: { teams, error in
            guard let teams = teams else{
                XCTAssertNil(teams, "Items Not nil")
                return
            }
        })
        
        
    }
    func testDecodingTeamFails(){
        networkManager = MockNetwork(shouldReturnError: false)
        Utilites.teamsMockItemsJSONResponse = """
                                        "menu": {
                                          "id": "file",
                                          "value": "File",
                                          "popup": {
                                            "menuitem": [
                                              {"value": "New", "onclick": "CreateNewDoc()"},
                                              {"value": "Open", "onclick": "OpenDoc()"},
                                              {"value": "Close", "onclick": "CloseDoc()"}
                                            ]
                                          }
                                        }}
"""
        networkManager?.getTeamData(sport: "", teamId: "", compilation: { teams, error in
            guard let teams = teams else{
                XCTAssertNil(teams, "Items Not nil")
                return
            }
        })
        
        
    }
    
    
    
}
