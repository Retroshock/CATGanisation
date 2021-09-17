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

    init(filters: [CategoryDisplayModel]) {
        self.dataSource.accept(filters)
    }
}
