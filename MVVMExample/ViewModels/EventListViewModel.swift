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
    
    var onUpdate = {}
    
    
    func viewDidLoad() {
        cells = [.event(EventCellViewModel()), .event(EventCellViewModel())]
        onUpdate()
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
}

