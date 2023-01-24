//
//  EventListCoordinator.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import UIKit
import CoreData

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController : UINavigationController
    var onSaveEvent = {}
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListViewController : EventListViewController = .instantiate()
        let eventListViewModel = EventListViewModel()
        onSaveEvent = eventListViewModel.reload
        eventListViewModel.coordinator = self
        eventListViewController.viewModel = eventListViewModel
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
     
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        let eventDetailCoordinator = EventDetailCoordinator(eventID: id, navigationController: navigationController)
        eventDetailCoordinator.parentCoordinator = self
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start()
    }
}
