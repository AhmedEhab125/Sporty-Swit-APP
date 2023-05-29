//
//  DataBaseProtocol.swift
//  Sporty
//
//  Created by ahmed on 30/05/2023.


import Foundation
protocol DataBaseProtocol{
    func addTeam(name : String , id :Int, img :Data,sport :String)
    func getTeams(compilation : @escaping ([FavouritTeamModel])->Void)
    func deleteTeam(index :Int)
}
