//
//  ClubDataPresenter.swift
//  Sporty
//
//  Created by ahmed on 26/05/2023.
//

import Foundation
class ClubDataPresenter{
    var network :NetworkProtocol
    var showTeamData :TeamDataProtocol
    var database :DataBaseProtocol
    init(network: NetworkProtocol, showTeamData: TeamDataProtocol, database: DataBaseProtocol) {
        self.network = network
        self.showTeamData = showTeamData
        self.database = database
    }
    func addTeamToDB( id :Int, name :String,img:Data,sport :String){
        database.addTeam(name: name, id: id, img: img,sport: sport)
    }
    func getTeamData(teamId:String,sport :String){
        network.getTeamData(sport: sport, teamId: teamId) { [weak self ]teamDataList
            , error in
            self?.showTeamData.getTeamData(teamData: teamDataList?[0])
        }
    }
}
