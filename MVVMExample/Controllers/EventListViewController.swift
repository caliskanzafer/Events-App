//
//  EventListViewController.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import UIKit
import CoreData
class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let plusCircleImage = UIImage(systemName: "plus.circle.fill")
        let rightBarButton = UIBarButtonItem(image: plusCircleImage, style: .plain, target: self, action: #selector(tappedAddEventBar))
        rightBarButton.tintColor = .primary
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func tappedAddEventBar () {
        viewModel.tappedAddEvent()
    }
    
}
