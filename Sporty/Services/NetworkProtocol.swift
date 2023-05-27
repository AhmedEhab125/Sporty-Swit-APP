//
//  File.swift
//  Sporty
//
//  Created by ahmed on 28/05/2023.
//

import Foundation
protocol NetworkProtocol{
     func getCountryData(sport: String,  compilation : @escaping ([LeaguesData]?,Error?)->Void)
     func getComingEvent(sport: String,fromDate : String ,toDate :String ,leagueid :String,  compilation : @escaping ([ComeEventData]?,Error?)->Void)
     func getTeams(sport: String,leagueid :String,  compilation : @escaping ([TeamData]?,Error?)->Void)
}
