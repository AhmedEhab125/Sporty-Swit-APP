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
    func showLeagues(sport : String){
        NetworkServise.getCountryData(sport: sport ) {[weak self] allLeagues in
            print("presenter \(allLeagues)")
            self?.leagueProtocol.setLeagues(list: allLeagues)
        }
    }
    
}

