//
//  BreedDetailsViewController.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 17.09.2021.
//

import Kingfisher
import UIKit

protocol BreedDetailsCoordinatorProtocol: Coordinator {

}

class BreedDetailsViewController: BaseViewController<BreedDetailsViewModel> {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var breedDescriptionLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var wikiLinkButton: UIButton!

    private var coordinator: BreedDetailsCoordinatorProtocol {
        coordinatorProtocol as! BreedDetailsCoordinatorProtocol
    }

    func configure(with viewModel: BreedDetailsViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.breed.breedName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.kf.setImage(with: viewModel.breed.imageURL)
        imageView.kf.indicatorType = .activity
        breedNameLabel.text = viewModel.breed.breedName
        breedDescriptionLabel.text = viewModel.breed.breedDescription
        countryCodeLabel.text = viewModel.breed.countryCode
        temperamentLabel.text = viewModel.breed.temperament
        if viewModel.breed.wikiLink == nil {
            wikiLinkButton.isHidden = true
        } else {
            wikiLinkButton.setTitle(viewModel.breed.wikiLink?.absoluteString, for: .normal)
        }
    }

    @IBAction func didPressWikiLink(_ sender: UIButton) {
        guard let link = viewModel.breed.wikiLink else { return }
        UIApplication.shared.open(link, options: [:])
    }
}
