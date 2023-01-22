//
//  EventsCellBuilder.swift
//  MVVMExample
//
//  Created by Zafer Çalışkan on 22.01.2023.
//

import Foundation

struct EventsCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil ) -> TitleSubtitleCellViewModel{
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(
                title: "Name",
                subtitle: "",
                placeholder: "Add a name",
                cellType: .text,
                onCellUpdate: onCellUpdate
            )
        case .date:
            return TitleSubtitleCellViewModel(
                title: "Date",
                subtitle: "",
                placeholder: "Select a date",
                cellType: .date,
                onCellUpdate: onCellUpdate
            )
        case .image:
            return TitleSubtitleCellViewModel(
                title: "Background",
                subtitle: "",
                placeholder: "",
                cellType: .image,
                onCellUpdate: onCellUpdate
            )
        }
    }
}
