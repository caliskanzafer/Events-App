//
//  EventCell.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 22.01.2023.
//

import UIKit

final class EventCell: UITableViewCell {
    
    private let timeRemainingStackView = TimeRemainingStackView()
    private let dateLabel = UILabel()
    private let eventNameLabel = UILabel()
    
    private let backgroundImage = UIImageView()
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        timeRemainingStackView.setup()
        
        [dateLabel, eventNameLabel, backgroundImage, verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        
        eventNameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        eventNameLabel.textColor = .white
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }
    
    private func setupHierarchy(){
        contentView.addSubview(backgroundImage)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        
        verticalStackView.addSubview(timeRemainingStackView)
        
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(dateLabel)
        
    }
    
    private func setupLayer(){
        backgroundImage.pinToSuperview([.left, .top, .right])
        let bottomConstraint = backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        
        backgroundImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pinToSuperview([.top, .right, .bottom], constant: 15)
        eventNameLabel.pinToSuperview([.left, .bottom], constant: 10)
//                dateLabel.pinToSuperview([.right, .bottom], constant: 10)
    }
    
    func update(with cell: EventCellViewModel){
        if let timeRemainingViewModel = cell.timeRemainingViewModel {
            timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        
        self.dateLabel.text = cell.dateText
        
        self.eventNameLabel.text = cell.eventName
        cell.loadImage { image in
            self.backgroundImage.image = image
        }
    }
    
}
