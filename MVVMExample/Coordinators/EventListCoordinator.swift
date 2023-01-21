//
//  EventListCoordinator.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import UIKit

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationController : UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListViewController = EventListViewController.instantiate()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.coordinator = self
        eventListViewController.viewModel = eventListViewModel
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        childCoordinator.append(addEventCoordinator)
        addEventCoordinator.start()
    }
}
