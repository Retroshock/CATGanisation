//
//  FilterCategoryTableViewCell.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 17.09.2021.
//

import UIKit

class FilterCategoryTableViewCell: UITableViewCell, ReusableNibCell {
    @IBOutlet private weak var checkboxImageView: UIImageView!
    @IBOutlet private weak var filterNameLabel: UILabel!

    private var category: CategoryDisplayModel?

    func configure(with category: CategoryDisplayModel) {
        self.category = category
        filterNameLabel.text = category.name
        if category.isSelected {
            checkboxImageView.image = UIImage(named: "checkboxChecked")
        } else {
            checkboxImageView.image = UIImage(named: "checkboxUnchecked")
        }
    }
}
