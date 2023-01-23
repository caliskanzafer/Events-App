//
//  EventListViewModel.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import Foundation

final class EventListViewModel {
    
    var coordinator: EventListCoordinator?
    let title = "Events"
    private(set) var cells: [Cell] = []
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    var onUpdate = {}
    
    
    func viewDidLoad() {
        reload()
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    func numberOfRows () -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func reload() {
        let event = coreDataManager.fetchEvent()
        cells = event.map {
            .event(EventCellViewModel($0))
        }
        onUpdate()
        
    }
}

