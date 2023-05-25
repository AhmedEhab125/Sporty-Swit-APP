//
//  ClubDataPresenter.swift
//  Sporty
//
//  Created by ahmed on 26/05/2023.
//

import Foundation
class ClubDataPresenter{
    func addTeamToDB(appDelegate :AppDelegate , id :Int, name :String,img:Data,sport :String){
        ClubDataBase.addTeam(appDeleate: appDelegate, name: name, id: id, img: img,sport: sport)
    }
}
