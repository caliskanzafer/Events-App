//
//  CoreDataManager.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "MVVMExample")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc : NSManagedObjectContext {
        persistentContainer.viewContext
    }
    


    
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try moc.existingObject(with: id) as? T
        }catch {
            print(error)
        }
        return nil
    }
    
    func getAll<T: NSManagedObject>() -> [T]{
        do {
            let nsFetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            return try moc.fetch(nsFetchRequest)
        }catch {
            print(error)
            return []
        }
        
    }
    
    
    func save() {
        do {
            try moc.save()
        }catch {
            print(error)
        }
    }
    
    
    //    func getEvent(_ id: NSManagedObjectID) -> Event? {
    //        do {
    //            return try moc.existingObject(with: id) as? Event
    //        }catch {
    //            print(error)
    //        }
    //        return nil
    //    }
}
