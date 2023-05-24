//
//  LeagueDetailsPresenter.swift
//  Sporty
//
//  Created by ahmed on 24/05/2023.
//

import Foundation
class LeagueDetailsPresenter{
    var comingEvent :ShowComingEventProtocol
    init(comingEvent: ShowComingEventProtocol) {
        self.comingEvent = comingEvent
    }
    func getEvents(sport :String,leagueId :String){
       
        NetworkServise.getComingEvent(sport: sport, fromDate: getCurrentDate(), toDate:getForDate(),leagueid: leagueId ){
            [weak self]data in
            self?.comingEvent.showEvents(eventList: data)
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
}
