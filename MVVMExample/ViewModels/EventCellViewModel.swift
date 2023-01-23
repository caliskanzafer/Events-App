//
//  EventCellViewModel.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 22.01.2023.
//
import UIKit

struct EventCellViewModel {
    private let event: Event
    let date = Date()
    private static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    
    private var cacheKey: String {
        event.objectID.description
    }
    
    var timeRemaining: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String? {
        guard let eventDate = event.date else { return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName: String? {
        return event.name
    }
    
    var backgroundImage: UIImage {
        guard let image = event.image else { return UIImage()}
        return UIImage(data: image) ?? UIImage()
    }
    
    init(_ event: Event) {
        self.event = event
    }
    
    func loadImage(completion: @escaping(UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        }else {
            imageQueue.async {
                guard let imageData = self.event.image, let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                    
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
}
