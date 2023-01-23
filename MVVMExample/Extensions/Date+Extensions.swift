//
//  Date+Extensions.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 23.01.2023.
//

import Foundation

extension Date {
    func timeRemaining(until date: Date) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to:date)
    }
}
