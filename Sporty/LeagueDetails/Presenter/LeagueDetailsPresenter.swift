//
//  LeagueDetailsPresenter.swift
//  Sporty
//
//  Created by ahmed on 24/05/2023.
//

import Foundation
class LeagueDetailsPresenter{
    var comingEvent :ShowComingEventProtocol
    var leagueScore : LeagueScoreProtocol
    var teams : TeamsProtocol
    var network :NetworkProtocol
    init(comingEvent: ShowComingEventProtocol, leagueScore: LeagueScoreProtocol, teams: TeamsProtocol, network: NetworkProtocol) {
        self.comingEvent = comingEvent
        self.leagueScore = leagueScore
        self.teams = teams
        self.network = network
    }
    func getEvents(sport :String,leagueId :String){
       
        network.getComingEvent(sport: sport, fromDate: getCurrentDate(), toDate:getForDate(),leagueid: leagueId ){
            [weak self]data ,error in
            self?.comingEvent.showEvents(eventList: data ?? [])
        }
    }
    func getScores(sport :String,leagueId :String){
       
        network.getComingEvent(sport: sport, fromDate: getlast14Days(), toDate:getDayBefore(),leagueid: leagueId ){
            [weak self]data,error in
            self?.leagueScore.getLeagueScores(scorelist: data ?? [])
        }
    }
    func getTeams(sport :String,leagueId :String){
       
        network.getTeams(sport: sport,leagueid: leagueId ){
            [weak self]data,error in
            self?.teams.getTeams(teamList: data ?? [])
        }
    }
    
    
    private func getCurrentDate()-> String{
        let date = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormater.string(from: date)
        return dateString
    }
    private func getForDate()->String{
        let currentDate = Date()
        let sevenDaysAfter = Calendar.current.date(byAdding: .day, value: 14, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: sevenDaysAfter)
        
        return formattedDate
    }
    
    
    
    private func getDayBefore()-> String{
        let currentDate = Date()
        let sevenDaysAfter = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formattedDate = dateFormatter.string(from: sevenDaysAfter)
        print(formattedDate)
        return formattedDate
    }
    private func getlast14Days()->String{
        let currentDate = Date()
        let sevenDaysAfter = Calendar.current.date(byAdding: .day, value: -90, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: sevenDaysAfter)
        print(formattedDate)
        return formattedDate
    }
    
}
