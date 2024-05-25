//
//  DataManager.swift
//  SportinG
//
//  Created by Rawan Elsayed on 23/05/2024.
//

import Foundation
import CoreData

class CoreDataManager{
    
    let coreDataUtils = CoreDataUtils()
    
    func saveToCoreData(leagueKey: String, leagueName: String, leagueLogo: String, sportName: String) {
        
        let context = coreDataUtils.appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteLeagues", in: context)
        let favNews = NSManagedObject(entity: entity!, insertInto: context)
        
        favNews.setValue(leagueKey, forKey: "leagueKey")
        favNews.setValue(leagueName, forKey: "leagueName")
        favNews.setValue(leagueLogo, forKey: "leagueLogo")
        favNews.setValue(sportName, forKey: "sportName")
        
        do {
            try context.save()
            print("League saved to Core Data")
        } catch {
            print("Error saving league to Core Data: \(error.localizedDescription)")
        }
    }
    
    func deleteFromCoreData(leagueKey: String) {
        
        let context = coreDataUtils.appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %@", leagueKey)
        
        do {
            let leagues = try context.fetch(fetchRequest)
            for league in leagues {
                context.delete(league as! NSManagedObject)
            }
            
            try context.save()
            print("League deleted from Core Data")
        } catch {
            print("Error deleting league from Core Data: \(error.localizedDescription)")
        }
    }
    
    func retrieveFromCoreData() -> [NSManagedObject]? {
        
        let context = coreDataUtils.appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteLeagues")
        
        do {
            let leagues = try context.fetch(fetchRequest) as? [NSManagedObject]
            return leagues
        } catch {
            print("Error retrieving leagues from Core Data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func leagueExistsInCoreData(leagueKey: String) -> Bool {
        
        let context = coreDataUtils.appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %@", leagueKey)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking if league exists in Core Data: \(error.localizedDescription)")
            return false
        }
    }
    
}
