//
//  CatsService.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 16.09.2021.
//

import Foundation
import RxSwift

class CatsService {
    let catsApi = resolve(CatsApi.self)

    func getBreeds(page: Int, limit: Int, filters: [FilterDisplayModel]) -> Single<[BreedResponse]> {
        catsApi.getBreeds(page: page, limit: limit, filters: filters)
    }
}
