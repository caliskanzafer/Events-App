//
//  TimeRemainingViewModel.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 24.01.2023.
//

import UIKit

final class TimeRemainingViewModel {
    
     enum Mode {
        case cell
        case detail
    }
    
    var fonsSize: CGFloat {
        switch mode {
        case .cell:
            return 25
        case .detail:
            return 60
        }
    }
    
    var alignment: UIStackView.Alignment {
        switch mode {
        case .cell:
            return .trailing
        case .detail:
            return .center
        }
    }
    
    let timeRemainingParts: [String]
    private let mode: Mode
    
    init(timeRemainingParts: [String], mode: Mode) {
        self.timeRemainingParts = timeRemainingParts
        self.mode = mode
    }
}
