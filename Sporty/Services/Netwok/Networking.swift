//
//  Networking.swift
//  Sporty
//
//  Created by ahmed  22/05/2023.
//
import Foundation
import Alamofire

class NetworkServise: NetworkProtocol{
    private init(){
        
    }
   static let getInstance = NetworkServise()
    
    func getCountryData(sport: String,  compilation : @escaping ([LeaguesData]?,Error?)->Void){
        print("entred")
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=f11f8f859313280681f3577a41e7c977e0e01a396104db190f79dedb5f4f4ad2").responseDecodable(of:LeaguesModel.self){response in
            switch response.result {
                
            case .success(let value):
                print(response.result)
                // Handle successful response
                print(value)
                print(value.result)
                compilation(value.result ,nil)
            case .failure(_):
                print(response.result)
                print("error")
                // Handle error
                compilation([],response.error)
                
            }
            
        }
    }
    func getComingEvent(sport: String,fromDate : String ,toDate :String ,leagueid :String,  compilation : @escaping ([ComeEventData]?,Error?)->Void){
        print("entred")
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=f11f8f859313280681f3577a41e7c977e0e01a396104db190f79dedb5f4f4ad2&from=\(fromDate)&to=\(toDate)&leagueId=\(leagueid)").responseDecodable(of:ComeEventModel.self){response in
            switch response.result {
                
            case .success(let value):
                print(response.result)
                // Handle successful response
                print(value)
                compilation(value.result ?? [],nil)
            case .failure(_):
                print(response.result)
                print("error")
                // Handle error
                compilation([],response.error)
                
            }
            
        }
    }
    func getTeams(sport: String,leagueid :String,  compilation : @escaping ([TeamData]?,Error?)->Void){
        print("entred \(leagueid)")
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&APIkey=f11f8f859313280681f3577a41e7c977e0e01a396104db190f79dedb5f4f4ad2&leagueId=\(leagueid)").responseDecodable(of:TeamsModel.self){response in
            
            switch response.result {
                
            case .success(let value):
                print(response.result)
                // Handle successful response
                print(value)
                compilation(value.result ,nil)
                print(value.result.count)
            case .failure(_):
                print(response.result)
                // Handle error
                compilation([],response.error)
                
            }
            
        }
    }
    func getTeamData(sport: String,teamId :String,  compilation : @escaping ([TeamData]?,Error?)->Void){
        print("entred \(teamId)")
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&APIkey=f11f8f859313280681f3577a41e7c977e0e01a396104db190f79dedb5f4f4ad2&teamId=\(teamId)").responseDecodable(of:TeamsModel.self){response in
            
            switch response.result {
                
            case .success(let value):
                print(response.result)
                // Handle successful response
                print(value)
                compilation(value.result ,nil)
                print(value.result.count)
            case .failure(_):
                print(response.result)
                // Handle error
                compilation([],response.error)
                
            }
            
        }
    }
    
    
    
}
