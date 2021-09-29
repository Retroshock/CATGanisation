//
//  FilterCountryTableViewCell.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 17.09.2021.
//

import UIKit

class FilterCountryTableViewCell: UITableViewCell, ReusableNibCell {
    @IBOutlet private weak var checkboxImageView: UIImageView!
    @IBOutlet private weak var filterNameLabel: UILabel!

    private var filter: FilterDisplayModel?

    func configure(with filter: FilterDisplayModel) {
        self.filter = filter
        filterNameLabel.text = filter.name
        if filter.isSelected {
            checkboxImageView.image = UIImage(named: "checkboxChecked")
        } else {
            checkboxImageView.image = UIImage(named: "checkboxUnchecked")
        }
    }
}
