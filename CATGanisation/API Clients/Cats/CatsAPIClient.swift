//
//  CatsAPIClient.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 13.09.2021.
//

import Alamofire
import Foundation
import RxSwift

class CatsAPIClient: BaseAPIClient, CatsApi {
    func getBreeds(page: Int, limit: Int, filters: [CategoryDisplayModel]) -> Single<[BreedResponse]> {
        let parameters: [String: Any]
        if filters.isEmpty {
            parameters = [
                "attach_breed": 0,
                "page": page,
                "limit": limit,
                "order": "asc"
            ]
        } else {
            parameters = [
                "attach_breed": 0,
                "page": page,
                "limit": limit,
                "order": "asc",
                "country_code": filters.map { $0.name }.joined(separator: ",")
            ]
        }
        return call(
            method: .get,
            endpoint: "v1/breeds",
            parameters: parameters
        )
    }

    func getCategories() -> Single<[CategoryResponse]> {
        call(
            method: .get,
            endpoint: "v1/categories"
        )
    }
}
