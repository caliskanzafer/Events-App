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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.onUpdate = {
            [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
    }
    
    private func setupViews() {
        let plusCircleImage = UIImage(systemName: "plus.circle.fill")
        let rightBarButton = UIBarButtonItem(image: plusCircleImage, style: .plain, target: self, action: #selector(tappedAddEventBar))
        rightBarButton.tintColor = .primary
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
    }
    
    @objc private func tappedAddEventBar () {
        viewModel.tappedAddEvent()
    }
    
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at: indexPath) {
        case .event(let eventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            cell.update(with: eventCellViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
