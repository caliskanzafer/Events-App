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
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
}

