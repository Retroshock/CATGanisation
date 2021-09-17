//
//  BreedsCoordinator.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 14.09.2021.
//

import UIKit
import RxSwift

class BreedsCoordinator: Coordinator {
    var children: [Coordinator] = []

    var endFlow: (() -> Void)?

    let disposeBag: DisposeBag = DisposeBag()

    var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let breedsViewController = instantiateViewController(ofType: BreedsViewController.self, inStoryboard: .breeds) { controller in
            controller.configure(viewModel: BreedsViewModel(), coordinator: self)
        }
        navigationController.pushViewController(breedsViewController, animated: true)
    }

    func finishedChildFlow(flow: Coordinator) {

    }

}

extension BreedsCoordinator: BreedsCoordinatorProtocol {
    func showFilters() {

    }

    func showDetails(of breed: BreedDisplayModel) {
        let breedDetailsViewController = instantiateViewController(
            ofType: BreedDetailsViewController.self,
            inStoryboard: .breeds
        ) { controller in
            controller.configure(with: BreedDetailsViewModel(breed: breed))
        }
        self.navigationController.pushViewController(breedDetailsViewController, animated: true)
    }
}
