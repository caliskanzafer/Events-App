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
    
    func saveEvent(name:String, date: Date, image: UIImage){
        let event = Event(context: moc)
        
        let imageData = image.jpegData(compressionQuality: 1)
        
        event.setValue(name, forKey: "name")
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        
        do {
            try moc.save()
        }catch {
            print(error)
        }
    }
    
    func fetchEvent() -> [Event]{
        do {
            let nsFetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try moc.fetch(nsFetchRequest)
            return events
        }catch {
            print(error)
            return []
        }
        
    }
}
