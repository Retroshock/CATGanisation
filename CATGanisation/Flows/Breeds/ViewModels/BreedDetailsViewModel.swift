//
//  BreedDetailsViewModel.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 17.09.2021.
//

import Foundation

class BreedDetailsViewModel: BaseViewModel {
    let breed: BreedDisplayModel

    init(breed: BreedDisplayModel) {
        self.breed = breed
    }
}
