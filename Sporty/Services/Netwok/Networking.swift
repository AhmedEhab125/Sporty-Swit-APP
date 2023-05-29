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
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f").responseDecodable(of:LeaguesModel.self){response in
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
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f&from=\(fromDate)&to=\(toDate)&leagueId=\(leagueid)").responseDecodable(of:ComeEventModel.self){response in
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
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f&leagueId=\(leagueid)").responseDecodable(of:TeamsModel.self){response in
            
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
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f&teamId=\(teamId)").responseDecodable(of:TeamsModel.self){response in
            
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
