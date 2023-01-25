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
    private let eventService: EventServiceProtocol
    
    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
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
        EventCellViewModel.imageCache.removeAllObjects()
        let events = eventService.getEvents()
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            
            return .event(eventCellViewModel)
        }
        onUpdate()
        
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}

