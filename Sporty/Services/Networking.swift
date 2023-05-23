//
//  Networking.swift
//  Sporty
//
//  Created by ahmed  22/05/2023.
//
import Foundation
import Alamofire

class NetworkServise{
    static func getCountryData(compilation : @escaping ([LeaguesData])->Void){
        print("entred")
        AF.request("https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f").responseDecodable(of:LeaguesModel.self){response in
                    switch response.result {
                         case .success(let value):
                             // Handle successful response
                        print(value)
                        print(value.result)
                            compilation(value.result )
                    case .failure(_):
                        print("error")
                             // Handle error
                        compilation([])
                             
                         }
                    
                }
    }
}
