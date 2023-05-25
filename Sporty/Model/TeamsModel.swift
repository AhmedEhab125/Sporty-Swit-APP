//
//  TeamsModel.swift
//  Sporty
//
//  Created by ahmed on 24/05/2023.
//

import Foundation


// MARK: - Welcome
struct TeamsModel: Codable {
    var success: Int
    var result: [TeamData]
}

// MARK: - Result
struct TeamData: Codable {
    var teamKey: Int
    var teamName: String
    var teamLogo: String?
    var players: [Player]?
    var coaches: [Coach]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players, coaches
    }
}

// MARK: - Coach
struct Coach: Codable {
    var coachName: String

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
      
    }
}

// MARK: - Player
struct Player: Codable {
    var playerKey: Int
    var playerName, playerNumber: String
    var playerType: PlayerType
    var playerAge, playerMatchPlayed, playerGoals, playerYellowCards: String
    var playerRedCards: String
    var playerImage: String?

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        case playerImage = "player_image"
    }
}

enum PlayerType: String, Codable {
    case defenders = "Defenders"
    case forwards = "Forwards"
    case goalkeepers = "Goalkeepers"
    case midfielders = "Midfielders"
}


