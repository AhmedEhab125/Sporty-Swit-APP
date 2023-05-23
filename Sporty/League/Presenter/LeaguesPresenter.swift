//
//  LeaguesPresenter.swift
//  Sporty
//
//  Created by ahmed on 23/05/2023.
//

import Foundation
class LeaguesPresenter{
    var leagueProtocol : leaguesProtocol
    init(leagueProtocol: leaguesProtocol) {
        self.leagueProtocol = leagueProtocol
    }
    func showLeagues(){
        NetworkServise.getCountryData {[weak self] allLeagues in
            self?.leagueProtocol.setLeagues(list: allLeagues)
        }
    }
    
}

