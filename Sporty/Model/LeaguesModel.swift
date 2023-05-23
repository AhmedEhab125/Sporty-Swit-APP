//
//  LeaguesModel.swift
//  Sporty
//
//  Created by ahmed on 23/05/2023.
//

import Foundation

// MARK: - Welcome
class LeaguesModel : Codable {
    var success: Int
    var result: [LeaguesData]
}

// MARK: - Result
class LeaguesData: Codable {
    let leagueKey: Int
        let leagueName: String
        let countryKey: Int
        let countryName: String
        let leagueLogo, countryLogo: String?

        enum CodingKeys: String, CodingKey {
            case leagueKey = "league_key"
            case leagueName = "league_name"
            case countryKey = "country_key"
            case countryName = "country_name"
            case leagueLogo = "league_logo"
            case countryLogo = "country_logo"
        }
}
