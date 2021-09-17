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
    func getBreeds(page: Int, limit: Int) -> Single<[BreedResponse]> {
        call(
            method: .get,
            endpoint: "v1/breeds",
            parameters: [
                "attach_breed": 0,
                "page": page,
                "limit": limit
            ]
        )
    }
}
