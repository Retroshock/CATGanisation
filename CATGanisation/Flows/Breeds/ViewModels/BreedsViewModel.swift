//
//  BreedsViewModel.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 14.09.2021.
//

import Foundation
import RxRelay
import RxSwift

class BreedsViewModel: BaseViewModel {
    enum Errors: Error {
        case noNextPageAction
        case noSelf
    }

    private let catsService: CatsService = resolve(CatsService.self)
    let dataSource = BehaviorRelay<[BreedDisplayModel]>(value: [])
    var filters: [FilterDisplayModel] = []
    var allFilters: Set<FilterDisplayModel> = []

    private let pageLimit = 10

    lazy private var paginationManager: PaginationManager<BreedDisplayModel> = {
        PaginationManager(
            pageInfo: PageInfo(limit: pageLimit),
            nextPageAction: { [weak self] in
                guard let self = self else { return .error(Errors.noNextPageAction) }
                return self.getBreeds()
            }
        )
    }()

    func getBreeds() -> Single<[BreedDisplayModel]> {
        catsService.getBreeds(
            page: paginationManager.pageInfo.offset,
            limit: paginationManager.pageInfo.limit, filters: filters
        ).map { [weak self] breeds in
            guard let self = self else { throw Errors.noSelf }
            if !self.filters.isEmpty {
                return self.mapBreeds(breeds).filter { self.filters.map { $0.name }.contains($0.countryCode) }
            } else {
                return self.mapBreeds(breeds)
            }
        }.do(onSuccess: { [weak self] breeds in
            guard let self = self else { return }
            let oldValues = self.dataSource.value
            self.dataSource.accept(oldValues + breeds)
        })
    }

    func getNextPage() -> Completable {
        paginationManager.getNextPage().asCompletable()
    }

    private func mapBreeds(_ breeds: [BreedResponse]) -> [BreedDisplayModel] {
        breeds.map {
            BreedDisplayModel(
                imageURL: URL(string: $0.image?.url ?? ""),
                breedName: $0.name,
                breedDescription: $0.breedResponseDescription,
                countryCode: $0.countryCode,
                temperament: $0.temperament,
                wikiLink: URL(string: $0.wikipediaURL ?? "")
            )
        }
    }

    func didFilter(_ filters: [FilterDisplayModel]) -> Completable {
        self.filters = filters
        paginationManager.reset()
        dataSource.accept([])
        return getBreeds().asCompletable()
    }
}
