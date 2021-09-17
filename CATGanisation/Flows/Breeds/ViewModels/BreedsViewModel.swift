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
            limit: paginationManager.pageInfo.limit
        ).map { [weak self] breeds in
            guard let self = self else { throw Errors.noSelf }
            return self.mapBreeds(breeds)
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
}
