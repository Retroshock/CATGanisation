//
//  BreedsViewModelTests.swift
//  CATGanisationTests
//
//  Created by Adrian Popovici on 17.09.2021.
//

import XCTest
@testable import CATGanisation
import Swinject
import SwinjectAutoregistration
import RxSwift

class BreedsViewModelTests: XCTestCase {
    enum MockError: Error {
        case unknown
    }
    class MockAPIClient: CatsApi {
        func getBreeds(page: Int, limit: Int, filters: [FilterDisplayModel]) -> Single<[BreedResponse]> {
            return .just([
                .mockResponse,
                .mockResponse
            ])
        }
    }

    final class MockModule: Assembly {
        func assemble(container: Container) {
            container.autoregister(CatsApi.self, initializer: MockAPIClient.init).inObjectScope(.container)
            container.autoregister(CatsService.self, initializer: CatsService.init).inObjectScope(.container)
        }
    }

    private let disposeBag = DisposeBag()
    private var viewModel: BreedsViewModel?

    override func setUp() {
        super.setUp()
        appContainer = Container()
        assembler = Assembler([MockModule()])
        viewModel = BreedsViewModel()
    }

    func test_GetBreeds() {
        let expectation = XCTestExpectation(description: "get 2 breeds")
        viewModel!.getBreeds().subscribe { breeds in
            XCTAssertTrue(breeds.count == 2)
            expectation.fulfill()
        } onFailure: { error in
            XCTFail("Error occured when getting breeds")
            expectation.fulfill()
        }.disposed(by: disposeBag)
        wait(for: [expectation], timeout: 0.1)
    }

    func test_DidResetFilters() {
        let expectation = XCTestExpectation(description: "reset data source and active filters")
        viewModel!.didFilter([]).subscribe(onCompleted: { [unowned self] in
            XCTAssertTrue(self.viewModel!.dataSource.value.count == 2) // getting back the values
            XCTAssertTrue(self.viewModel!.filters.isEmpty)
            expectation.fulfill()
        }) { error in
            XCTFail("Error at reseting filters")
            expectation.fulfill()
        }.disposed(by: disposeBag)

        wait(for: [expectation], timeout: 0.1)
    }
}

private extension BreedResponse {
    static var mockResponse: BreedResponse {
        return BreedResponse(adaptability: 0, affectionLevel: 0, altNames: "", cfaURL: nil, childFriendly: 1, countryCode: "", countryCodes: "", breedResponseDescription: "", dogFriendly: 1, energyLevel: 1, experimental: 1, grooming: 1, hairless: 1, healthIssues: 1, hypoallergenic: 1, id: "ID", image: nil, indoor: 1, intelligence: 1, lap: 1, lifeSpan: "200", name: "Breed1", natural: 1, origin: "", rare: 1, referenceImageID: nil, rex: 1, sheddingLevel: 1, shortLegs: 1, socialNeeds: 1, strangerFriendly: 1, suppressedTail: 1, temperament: "", vcahospitalsURL: "", vetstreetURL: "", vocalisation: 1, weight: Weight(imperial: "1", metric: "2"), wikipediaURL: "", bidability: 1, catFriendly: 1)
    }
}
