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
    init(network: NetworkProtocol, showTeamData: TeamDataProtocol) {
        self.network = network
        self.showTeamData = showTeamData
    }
    func addTeamToDB(appDelegate :AppDelegate , id :Int, name :String,img:Data,sport :String){
        ClubDataBase.addTeam(appDeleate: appDelegate, name: name, id: id, img: img,sport: sport)
    }
    func getTeamData(teamId:String,sport :String){
        network.getTeamData(sport: sport, teamId: teamId) { [weak self ]teamDataList
            , error in
            self?.showTeamData.getTeamData(teamData: teamDataList?[0])
        }
    }
}
