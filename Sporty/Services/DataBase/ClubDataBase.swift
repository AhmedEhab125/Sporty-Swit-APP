//
//  ClubDataBase.swift
//  Sporty
//
//  Created by ahmed on 26/05/2023.
//

import Foundation
import CoreData

class ClubDataBase :DataBaseProtocol{
    private var appDeleate : AppDelegate
    private static var clubDatabaseInstance : ClubDataBase? = nil
    private init(appDeleate: AppDelegate) {
        self.appDeleate = appDeleate
    }
    static func getInstance(appDeleate : AppDelegate)->ClubDataBase{
        if clubDatabaseInstance == nil{
            clubDatabaseInstance = ClubDataBase(appDeleate: appDeleate)
        }
        return self.clubDatabaseInstance!
        
    }
     func addTeam(name : String , id :Int, img :Data,sport :String){
        
        getTeams() { favTeams in
            var flag = true
            favTeams.forEach { item in
                if(item.id == id){
                    flag = false
                }
            }
            if flag==true{
                let context : NSManagedObjectContext = self.appDeleate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "ClubData", in: context)
                let club = NSManagedObject(entity: entity!, insertInto: context)
                club.setValue(id, forKey: "id")
                club.setValue(name, forKey: "name")
                club.setValue(img, forKey: "club_img")
                club.setValue(sport, forKey: "sport")
                try? context.save()
            }
        }
        

    }
     func getTeams(compilation : @escaping ([FavouritTeamModel])->Void){
        var teamList :[FavouritTeamModel] = []
        var context : NSManagedObjectContext = appDeleate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "ClubData")
        let data  = try? context.fetch(fetchReq)
        data?.forEach({ team in
            let teamName = team.value(forKey: "name")
            let teamId = team.value(forKey: "id")
            let teamImg = team.value(forKey: "club_img")
            let sportType = team.value(forKey: "sport")
            let data = FavouritTeamModel(id: teamId as? Int, name: teamName as? String, img: teamImg as? Data,sport: sportType as? String)
                teamList.append(data)
            
            
        
            
        })
        compilation(teamList)
    }
     func deleteTeam(index :Int){
        var context : NSManagedObjectContext = appDeleate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "ClubData")
        guard let  data  = try? context.fetch(fetchReq)else{
            return
        }
        context.delete((data[index]))
       try? context.save()
            
      
    }
    
    
}
