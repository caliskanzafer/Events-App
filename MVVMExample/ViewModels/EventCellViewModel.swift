//
//  EventCellViewModel.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 22.01.2023.
//
import UIKit

struct EventCellViewModel {
    var yearText: String {
        "1 year"
    }
    
    var monthText: String {
        "3 months"
    }
    
    var weekText: String {
        "2 weeks"
    }
    
    var dayText: String {
        "2 days"
    }
    
    var dateText: String {
        "25 May 2023"
    }
    
    var eventName: String {
        "Swift Learning"
    }
    
    var backgroundImage: UIImage {
        UIImage(imageLiteralResourceName: "new-year")
    }
}
