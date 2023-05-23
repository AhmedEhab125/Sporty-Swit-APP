//
//  Networking.swift
//  Sporty
//
//  Created by ahmed  22/05/2023.
//
import Foundation
import Alamofire

class NetworkServise{
    static func getCountryData(compilation : @escaping ([CountryData])->Void){
        AF.request("https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=d4d36a82c366990594031fcf550110d9806b8eebabdad1dd07fcf5878a8cd08f").responseDecodable(of:CountryModel.self){response in
                    switch response.result {
                         case .success(let value):
                             // Handle successful response
                        print(value)
                            compilation(value.result as [CountryData])
                    case .failure(_):
                             // Handle error
                        compilation([])
                             
                         }
                    
                }
    }
}
