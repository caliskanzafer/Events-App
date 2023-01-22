//
//  AddEventCoordinator.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    private var completion: (UIImage) -> Void = { _ in }
    
    
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.modalNavigationController = UINavigationController()
        let addEventViewController : AddEventViewController = .instantiate()
        modalNavigationController?.setViewControllers([addEventViewController], animated: false)
        let addEventViewModel = AddEventViewModel(eventsCellBuilder: EventsCellBuilder(), coreDataManager: CoreDataManager())
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: false)
        }
        
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSaveEvent(){
        navigationController.dismiss(animated: false)
    }
    
    func showImagePicker(completion: @escaping(UIImage) -> Void) {
        self.completion = completion
        guard let modalNavigationController = modalNavigationController else { return }
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func didFinishImagePicking(_ image: UIImage) {
        completion(image)
        modalNavigationController?.dismiss(animated: false)
    }
    
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
