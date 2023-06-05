//
//  NetworkServiceTest.swift
//  SportyTests
//
//  Created by ahmed on 28/05/2023.
//

import XCTest
@testable import Sporty

final class NetworkServiceTest: XCTestCase {
    let network = NetworkServise.getInstance

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Putteardown code here. This method is called after the invocation of each test method in the class.
    }
    func testLoadDataFromLeaguesURL(){
        let myExpectation = expectation(description: "waiting for the API")
        network.getCountryData(sport: "football") {
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
    func testLoadDataFromLeaguesURLShouldFail(){
        let myExpectation = expectation(description: "waiting for the API")
        network.getCountryData(sport: "football5") {
            listLeagues,error in
            
            guard let listLeagues  = listLeagues else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
           
            //XCTAssertGreaterThan(listLeagues.count, 0, "Array is Empty")
            XCTAssertEqual(listLeagues.count, 0, "Array is not Empty")
            myExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 12, handler: nil)
    }
    func testLoadDataFromComeEventURL(){
        let myExpectation = expectation(description: "waiting for the API")
        network.getComingEvent(sport: "football", fromDate: "2023-05-10", toDate: "2023-06-10", leagueid: "45") { listComeEventData,error in
            
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
    func testLoadDataFromComeEventURLShouldFail(){
        let myExpectation = expectation(description: "waiting for the API")
        network.getComingEvent(sport: "football3", fromDate: "2023-05-10", toDate: "2023-06-10", leagueid: "45") { listComeEventData,error in
            
            guard case let data  = listComeEventData else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            //XCTAssertGreaterThan(data!.count, 0, "Array is Empty")
            XCTAssertEqual(data!.count, 0, "Array is not Empty")
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 12 ,handler: nil)
    }
    func testLoadDataFromTeamsURL(){
        let myExpectation = expectation(description: "waiting for the API")
        network.getTeams(sport: "football", leagueid: "45") { listTeamData,error in
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
    func testLoadDataFromTeamsURLShoudFail(){
        let myExpectation = expectation(description: "waiting for the API")
        network.getTeams(sport: "football3", leagueid: "45") { listTeamData,error in
            guard let data
                    = listTeamData else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertEqual(data.count, 0,  "Array is not Empty")
            myExpectation.fulfill()
            
            
        }
        waitForExpectations(timeout: 12 ,handler: nil)
    }
    func testLoadDataFromTeamsDataURL(){
        let myExpectation = expectation(description: "waiting for the API")
        network.getTeamData(sport: "football", teamId:  "45") { listTeamData,error in
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
    func testLoadDataFromTeamsDataURLShoudFail(){
        let myExpectation = expectation(description: "waiting for the API")
        network.getTeamData(sport: "footballd", teamId:  "45") { listTeamData,error in
            guard let data
                    = listTeamData else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertEqual(data.count, 0,  "Array is not Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
            
            
        }
        waitForExpectations(timeout: 12 ,handler: nil)
    }
        

 

}
