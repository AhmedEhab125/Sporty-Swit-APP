//
//  FavouriteTeamsPresenter.swift
//  Sporty
//
//  Created by ahmed on 26/05/2023.
//

import Foundation
class FavouriteTeamsPresenter{
    var favTeams :FavouritTeamsProtocol
    var database :DataBaseProtocol
    init(favTeams: FavouritTeamsProtocol, database: DataBaseProtocol) {
        self.favTeams = favTeams
        self.database = database
    }
    func getFavouriteTeams(){
        database.getTeams() { [weak self]
            teamList in
            self?.favTeams.showTeams(list: teamList)
        }
    }
    func deleteFromFavourite(team: Int){
        database.deleteTeam( index: team)
    }
}


