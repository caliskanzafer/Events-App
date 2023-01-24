//
//  EventDetailViewModel.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 24.01.2023.
//

import CoreData
import UIKit

final class EventDetailViewModel {
    private let eventID: NSManagedObjectID
    private let coreDataManager: CoreDataManager
    private var event: Event?
    private let date = Date()
    var coordinator: EventDetailCoordinator?
    var onUpdate = {}
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event?.date, let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else { return nil }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
    }
    
    var image: UIImage? {
        guard let image = event?.image else { return nil}
        return UIImage(data: image)
    }
    
    init(eventID: NSManagedObjectID, coreDataManager: CoreDataManager = .shared){
        self.eventID = eventID
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        event = coreDataManager.getEvent(eventID)
        onUpdate()
    }
    
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
}
