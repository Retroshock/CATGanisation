//
//  BreedTableViewCell.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 14.09.2021.
//

import UIKit
import Kingfisher

class BreedTableViewCell: UITableViewCell, ReusableNibCell {

    @IBOutlet private weak var breedImageView: UIImageView!
    @IBOutlet private weak var breedTitleLabel: UILabel!
    @IBOutlet private weak var breedDescriptionLabel: UILabel!

    private var breed: BreedDisplayModel?

    func configure(with breed: BreedDisplayModel) {
        self.breed = breed
        self.breedImageView.kf.setImage(with: breed.imageURL)
        self.breedImageView.kf.indicatorType = .activity
        self.breedTitleLabel.text = breed.breedName
        self.breedDescriptionLabel.text = breed.breedDescription
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
