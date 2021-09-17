//
//  FiltersViewModel.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 17.09.2021.
//

import Foundation
import RxRelay
import RxSwift

class FiltersViewModel: BaseViewModel {
    let catsService = resolve(CatsService.self)
    let dataSource = BehaviorRelay<[CategoryDisplayModel]>(value: [])

    func getFilters() -> Single<[CategoryDisplayModel]> {
        catsService.getFilterCategories().map { categories in
            categories.map { CategoryDisplayModel(id: $0.id, name: $0.name) }
        }.do(onSuccess: { [weak self] categories in
            guard let self = self else { return }
            let oldValues = self.dataSource.value
            self.dataSource.accept(oldValues + categories)
        })
    }
}
