//
//  TitleSubtitleCellViewModel.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//
import Foundation

final class TitleSubtitleCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    private(set) var subtitle: String
    let placeholder: String
    let cellType: CellType
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    var onUpdate: () -> Void = {}
    
    init(title: String, subtitle: String, placeholder: String, cellType: CellType, onCellUpdate: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.cellType = cellType
        self.onUpdate = onCellUpdate
    }
    
    func update(_ subtitle: String){
        self.subtitle = subtitle
    }
    
    func update(_ date: Date){
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onUpdate()
    }
}
