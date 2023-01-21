//
//  AddEventCoordinator.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .brown
        navigationController.present(viewController, animated: false)
        // Create add event view controller
        // Create add event view model
        // present modally controller using navigation controller
    }
    
    
}
