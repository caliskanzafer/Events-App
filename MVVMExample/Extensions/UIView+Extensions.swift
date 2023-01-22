//
//  UIView+Extensions.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 22.01.2023.
//

import UIKit

enum Edge {
    case left
    case top
    case right
    case bottom
    
}
extension UIView {
    func pinToSuperview(_ edges: [Edge] = [.left, .top, .right, .bottom], constant: CGFloat = 0) {
        guard let superview = superview else { return }
        edges.forEach {
            switch $0 {
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
}
