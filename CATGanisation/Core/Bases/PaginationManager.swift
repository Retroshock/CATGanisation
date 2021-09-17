//
//  PaginationManager.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 16.09.2021.
//

import Foundation
import RxSwift

struct PageInfo {
    var limit: Int
    var offset: Int
    var total: Int

    init(limit: Int = 40, offset: Int = 0, total: Int = 0) {
        self.limit = limit
        self.offset = offset
        self.total = total
    }
}

class PaginationManager<T> {
    enum Errors: Error {
        case alreadyPaginating
        case noMorePages
    }

    var pageInfo: PageInfo

    var nextPageAction: () -> Single<[T]>
    var isPaginating = false
    var shouldGetMore: Bool = true

    init(pageInfo: PageInfo, nextPageAction: @escaping () -> Single<[T]>) {
        self.pageInfo = pageInfo
        self.nextPageAction = nextPageAction
    }

    func incrementPage() {
        pageInfo.offset += 1
    }

    func decrementPage() {
        pageInfo.offset -= 1
    }

    func getNextPage() -> Single<[T]> {
        guard isPaginating == false else { return .error(Errors.alreadyPaginating) }
        guard shouldGetMore else {
            return .error(Errors.noMorePages)
        }
        isPaginating = true
        incrementPage()
        return nextPageAction().flatMap { [weak self] model in
            guard let self = self else { return .just(model) }
            self.isPaginating = false
            if model.isEmpty {
                self.shouldGetMore = false
            }
            return .just(model)
        }.do(onError: { [weak self] _ in
            self?.isPaginating = false
            self?.decrementPage()
        })
    }

    func gotInitialPageWith(numberOfItems: Int, total: Int? = nil) {
        update(offset: numberOfItems)
        if let total = total {
            update(total: total)
        }
    }

    func addNumberOfItems(_ value: Int) {
        pageInfo.total += value
        pageInfo.offset += value
    }

    func resetOffset() {
        pageInfo.offset = 0
    }

    func resetTotal() {
        pageInfo.total = 0
    }

    func reset() {
        resetOffset()
        resetTotal()
        isPaginating = false
    }

    func update(total: Int) {
        pageInfo.total = total
    }

    func update(offset: Int) {
        pageInfo.offset = offset
    }
}

protocol PaginatingViewModel {
    associatedtype Model
    var pageLimit: Int { get }
    var paginationManager: PaginationManager<Model> { get set }
}
