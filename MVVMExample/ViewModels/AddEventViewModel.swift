//
//  AddEventViewModel.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import UIKit

final class AddEventViewModel {
    
    let title = "Add"
    
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    var coordinator: AddEventCoordinator?
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageViewModel: TitleSubtitleCellViewModel?
    
    private let eventsCellBuilder: EventsCellBuilder
    private let coreDataManager: CoreDataManager
    
    lazy var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    
    init(eventsCellBuilder: EventsCellBuilder, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.eventsCellBuilder = eventsCellBuilder
        self.coreDataManager = coreDataManager
    }
    func viewDidLoad(){
        setupCells()
        onUpdate()
    }
    
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subtitle, let dateString = dateCellViewModel?.subtitle, let image = backgroundImageViewModel?.image, let date = dateFormatter.date(from: dateString) else { return }
        coreDataManager.saveEvent(name: name, date: date, image: image)
        coordinator?.didFinishSaveEvent()
        
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.cellType == .image else {
                return
            }
            
            coordinator?.showImagePicker {
                image in
                titleSubtitleCellViewModel.update(image)
            }
        }
    }
}

private extension AddEventViewModel {
    func setupCells() {
        nameCellViewModel = eventsCellBuilder.makeTitleSubtitleCellViewModel(.text)
        
        dateCellViewModel = eventsCellBuilder.makeTitleSubtitleCellViewModel(.date, onCellUpdate: {
            [weak self] in
            self?.onUpdate()
        })
        
        backgroundImageViewModel = eventsCellBuilder.makeTitleSubtitleCellViewModel(.image, onCellUpdate: {
            [weak self] in
            self?.onUpdate()
        })
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageViewModel = backgroundImageViewModel else { return }
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundImageViewModel),
        ]
    }
}
