//
//  ComeEventModel.swift
//  Sporty
//
//  Created by ahmed on 23/05/2023.
//

import Foundation


// MARK: - Welcome
class ComeEventModel: Codable {
    
    var success : Int?      = nil
    var result  : [ComeEventData]? = []
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case result  = "result"
        
    }
    
}

// MARK: - Result
class ComeEventData: Codable {
    var eventFirstPlayer: String?
    var firstPlayerKey: Int?
    var eventSecondPlayer: String?
    var secondPlayerKey: Int?
    var eventHomeFinalResult, eventAwayFinalResult: String?
    var eventHomeTeamLogo, eventAwayTeamLogo: String?
    var eventDateStart: String?

    var eventKey            : Int?           = nil
    var eventDate           : String?        = nil
    var eventTime           : String?        = nil
    var eventHomeTeam       : String?        = nil
    var homeTeamKey         : Int?           = nil
    var eventAwayTeam       : String?        = nil
    var awayTeamKey         : Int?           = nil
    var eventHalftimeResult : String?        = nil
    var eventFinalResult    : String?        = nil
    var eventFtResult       : String?        = nil
    var eventPenaltyResult  : String?        = nil
    var eventStatus         : String?        = nil
    var countryName         : String?        = nil
    var leagueName          : String?        = nil
    var leagueKey           : Int?           = nil
    var leagueRound         : String?        = nil
    var leagueSeason        : String?        = nil
    var eventLive           : String?        = nil
    var eventStadium        : String?        = nil
    var eventReferee        : String?        = nil
    var homeTeamLogo        : String?        = nil
    var awayTeamLogo        : String?        = nil
    var eventCountryKey     : Int?           = nil
    var leagueLogo          : String?        = nil
    var countryLogo         : String?        = nil
    var eventHomeFormation  : String?        = nil
    var eventAwayFormation  : String?        = nil
    var fkStageKey          : Int?           = nil
    var stageName           : String?        = nil
    var leagueGroup         : String?        = nil
    
    enum CodingKeys: String, CodingKey {
        
        case eventKey            = "event_key"
        case eventDate           = "event_date"
        case eventTime           = "event_time"
        case eventHomeTeam       = "event_home_team"
        case homeTeamKey         = "home_team_key"
        case eventAwayTeam       = "event_away_team"
        case awayTeamKey         = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult    = "event_final_result"
        case eventFtResult       = "event_ft_result"
        case eventPenaltyResult  = "event_penalty_result"
        case eventStatus         = "event_status"
        case countryName         = "country_name"
        case leagueName          = "league_name"
        case leagueKey           = "league_key"
        case leagueRound         = "league_round"
        case leagueSeason        = "league_season"
        case eventLive           = "event_live"
        case eventStadium        = "event_stadium"
        case eventReferee        = "event_referee"
        case homeTeamLogo        = "home_team_logo"
        case awayTeamLogo        = "away_team_logo"
        case eventCountryKey     = "event_country_key"
        case leagueLogo          = "league_logo"
        case countryLogo         = "country_logo"
        case eventHomeFormation  = "event_home_formation"
        case eventAwayFormation  = "event_away_formation"
        case fkStageKey          = "fk_stage_key"
        case stageName           = "stage_name"
        case leagueGroup         = "league_group"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventHomeFinalResult = "event_home_final_result"
        case eventAwayFinalResult = "event_away_final_result"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        case eventDateStart = "event_date_start"

        
    }
    
    
    
    
    
}



// MARK: - Statistic
class Statistic: Codable {
    var type: TypeEnum
    var home, away: String
    
    init(type: TypeEnum, home: String, away: String) {
        self.type = type
        self.home = home
        self.away = away
    }
}

enum TypeEnum: String, Codable {
    case ballPossession = "Ball Possession"
    case corners = "Corners"
    case fouls = "Fouls"
    case offsides = "Offsides"
    case passesAccurate = "Passes Accurate"
    case passesTotal = "Passes Total"
    case redCards = "Red Cards"
    case saves = "Saves"
    case shotsBlocked = "Shots Blocked"
    case shotsInsideBox = "Shots Inside Box"
    case shotsOffGoal = "Shots Off Goal"
    case shotsOnGoal = "Shots On Goal"
    case shotsOutsideBox = "Shots Outside Box"
    case shotsTotal = "Shots Total"
    case yellowCards = "Yellow Cards"
}

// MARK: - Substitute




