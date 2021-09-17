//
//  CatsAPI.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 13.09.2021.
//

import Foundation
import RxSwift

protocol CatsApi {
    func getBreeds(page: Int, limit: Int) -> Single<[BreedResponse]>
}
