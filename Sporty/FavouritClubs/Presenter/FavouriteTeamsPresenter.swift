//
//  FavouriteTeamsPresenter.swift
//  Sporty
//
//  Created by ahmed on 26/05/2023.
//

import Foundation
class FavouriteTeamsPresenter{
    var favTeams :FavouritTeamsProtocol
    init(favTeams: FavouritTeamsProtocol) {
        self.favTeams = favTeams
    }
    func getFavouriteTeams(appDelegat:AppDelegate){
        ClubDataBase.getTeams(appDeleate: appDelegat) { [weak self]
            teamList in
            self?.favTeams.showTeams(list: teamList)
        }
    }
}


