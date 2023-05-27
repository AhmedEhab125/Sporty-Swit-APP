//
//  LeaguesPresenter.swift
//  Sporty
//
//  Created by ahmed on 23/05/2023.
//

import Foundation
class LeaguesPresenter{
    var leagueProtocol : leaguesProtocol
    var network :NetworkProtocol
    init(leagueProtocol: leaguesProtocol, network: NetworkProtocol) {
        self.leagueProtocol = leagueProtocol
        self.network = network
    }
    
    func showLeagues(sport : String){
        network.getCountryData(sport: sport ) {[weak self] allLeagues ,error in
            print("presenter \(allLeagues)")
            self?.leagueProtocol.setLeagues(list: allLeagues ?? [])
        }
    }
    
}

