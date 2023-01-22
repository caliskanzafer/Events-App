//
//  TitleSubtitleTableViewCell.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 21.01.2023.
//

import UIKit


final class TitleSubtitleCell: UITableViewCell {
    private var viewModel: TitleSubtitleCellViewModel?
    
    private let titleLabel = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    private let constant: CGFloat = 15
    
    private let datePickerView = UIDatePicker()
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 35))
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
    }()
    
    private let photoImageView: UIImageView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
        
        subtitleTextField.inputView = viewModel.cellType == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.cellType == .text ? nil : toolbar
        
        photoImageView.isHidden = viewModel.cellType != .image
        photoImageView.image = viewModel.image
        
        subtitleTextField.isHidden = viewModel.cellType == .image
        verticalStackView.spacing = viewModel.cellType == .image ? 15 : verticalStackView.spacing
    }
    
    func setupViews(){
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
        
        [verticalStackView, titleLabel, subtitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        toolbar.setItems([doneButton], animated: false)
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .date
        
        photoImageView.backgroundColor = .black.withAlphaComponent(0.4)
        photoImageView.layer.cornerRadius = 10
        
       
    }
    
    func setupHierarchy(){
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: constant),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -constant),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant),
        ])
        
        photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func doneTapped() {
        viewModel?.update(datePickerView.date)
    }
}
