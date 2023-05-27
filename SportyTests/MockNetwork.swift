//
//  MockNetwork.swift
//  SportyTests
//
//  Created by ahmed on 28/05/2023.
//

import Foundation
@testable import Sporty
class MockNetwork{
    var shouldReturnError: Bool
    init(shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    
    enum ResponseWithError : Error {
        case responseError
    }
    
}
extension MockNetwork:NetworkProtocol{
    func getCountryData(sport: String, compilation: @escaping ([Sporty.LeaguesData]?, Error?) -> Void) {
        if shouldReturnError{
            compilation(nil, ResponseWithError.responseError )
        }else{
       
            let data = try? JSONDecoder().decode(LeaguesModel.self, from: Utilites.leagueMockItemsJSONResponse.data(using: .utf8)! )
            compilation(data?.result, nil )
            
        }
    }
    
    func getComingEvent(sport: String, fromDate: String, toDate: String, leagueid: String, compilation: @escaping ([Sporty.ComeEventData]?, Error?) -> Void) {
        if shouldReturnError{
            compilation(nil, ResponseWithError.responseError )
        }else{
       
            let data = try? JSONDecoder().decode(ComeEventModel.self, from: Utilites.comeEventsMockItemsJSONResponse.data(using: .utf8)! )
            compilation(data?.result!, nil )
            
        }
    }
    
    func getTeams(sport: String, leagueid: String, compilation: @escaping ([Sporty.TeamData]?, Error?) -> Void) {
        if shouldReturnError{
            compilation(nil, ResponseWithError.responseError )
        }else{
       
            let data = try? JSONDecoder().decode(TeamsModel.self, from: Utilites.teamsMockItemsJSONResponse.data(using: .utf8)! )
            compilation(data?.result ?? [], nil )
            
        }
    }
    
     
    
}
