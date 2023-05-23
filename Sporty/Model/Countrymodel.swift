//
//  Countrymodel.swift
//  Sporty
//
//  Created by ahmed on 22/05/2023.
//

import Foundation
class CountryModel: Codable {
    let success: Int
    let result: [CountryData]
}

// MARK: - Result
class CountryData: Codable {
    let countryKey: Int
    let countryName: String
    let countryIso2: String?
    let countryLogo: String?

    enum CodingKeys: String, CodingKey {
        case countryKey = "country_key"
        case countryName = "country_name"
        case countryIso2 = "country_iso2"
        case countryLogo = "country_logo"
    }
}
