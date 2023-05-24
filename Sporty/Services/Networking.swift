//
//  Networking.swift
//  Sporty
//
//  Created by ahmed  22/05/2023.
//
import Foundation
import Alamofire

class NetworkServise{
    var upComingEvent = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f&from=2023-05-24&to=2023-06-8"
    static func getCountryData(sport: String,  compilation : @escaping ([LeaguesData])->Void){
        print("entred")
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f").responseDecodable(of:LeaguesModel.self){response in
                    switch response.result {
                       
                         case .success(let value):
                        print(response.result)
                             // Handle successful response
                        print(value)
                        print(value.result)
                            compilation(value.result )
                    case .failure(_):
                        print(response.result)
                        print("error")
                             // Handle error
                        compilation([])
                             
                         }
                    
                }
    }
    static func getComingEvent(sport: String,fromDate : String ,toDate :String ,leagueid :String,  compilation : @escaping ([ComeEventData])->Void){
        print("entred")
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f&from=\(fromDate)&to=\(toDate)&leagueId=\(leagueid)").responseDecodable(of:ComeEventModel.self){response in
                    switch response.result {
                       
                         case .success(let value):
                        print(response.result)
                             // Handle successful response
                        print(value)
                        print(value.result)
                        compilation(value.result ?? [])
                    case .failure(_):
                        print(response.result)
                        print("error")
                             // Handle error
                        compilation([])
                             
                         }
                    
                }
    }
    static func getTeams(sport: String,leagueid :String,  compilation : @escaping ([ComeEventData])->Void){
        print("entred")
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f&leagueId=\(leagueid)").responseDecodable(of:ComeEventModel.self){response in
                    switch response.result {
                       
                         case .success(let value):
                        print(response.result)
                             // Handle successful response
                        print(value)
                        compilation(value.result ?? [])
                    case .failure(_):
                        print(response.result)
                             // Handle error
                        compilation([])
                             
                         }
                    
                }
    }
    
    
    

}
