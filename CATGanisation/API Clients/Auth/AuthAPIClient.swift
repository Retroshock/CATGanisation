//
//  AuthAPIClient.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 13.09.2021.
//

import Alamofire
import Foundation
import RxSwift

class AuthAPIClient: BaseAPIClient, AuthApi {
    func login(username: String, password: String) -> Single<LoginResponse> {
        call(
            method: .post,
            endpoint: "/login",
            query: [
                "username": username,
                "password": password
            ]
        )
    }

    func logout() -> Single<LogoutResponse> {
        call(
            method: .post,
            endpoint: "/logout"
        )
    }
}
