//
//  NetworkServiceTest.swift
//  SportyTests
//
//  Created by ahmed on 28/05/2023.
//

import XCTest
@testable import Sporty

final class NetworkServiceTest: XCTestCase {
    let network = NetworkServise()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Putteardown code here. This method is called after the invocation of each test method in the class.
    }
    func testLoadDataFromLeaguesURL(){
        let myExpectation = expectation(description: "waiting for the API")
        NetworkServise().getCountryData(sport: "football") {
            listLeagues,error in
            
            guard let listLeagues  = listLeagues else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
           
            XCTAssertGreaterThan(listLeagues.count, 0, "Array is Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 12, handler: nil)
    }
    func testLoadDataFromComeEventURL(){
        let myExpectation = expectation(description: "waiting for the API")
        NetworkServise().getComingEvent(sport: "football", fromDate: "2023-05-10", toDate: "2023-06-10", leagueid: "45") { listComeEventData,error in
            
            guard case let data  = listComeEventData else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(data!.count, 0, "Array is Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 12 ,handler: nil)
    }
    func testLoadDataFromTeamsURL(){
        let myExpectation = expectation(description: "waiting for the API")
        NetworkServise().getTeams(sport: "football", leagueid: "45") { listTeamData,error in
            guard let data
                    = listTeamData else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(data.count, 0, "Array is Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
            
            
        }
        waitForExpectations(timeout: 12 ,handler: nil)
    }
        

 

}
