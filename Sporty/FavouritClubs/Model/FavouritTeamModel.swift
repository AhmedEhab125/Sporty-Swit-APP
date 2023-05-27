//
//  FavouritTeamModel.swift
//  Sporty
//
//  Created by ahmed on 26/05/2023.
//

import Foundation
struct FavouritTeamModel{
    var id : Int?
    var name : String?
    var img : Data?
    var sport :String?
    init(id: Int?, name: String?, img: Data?, sport: String?) {
        self.id = id
        self.name = name
        self.img = img
        self.sport = sport
    }
    
}
