//
//  AuthAPI.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 13.09.2021.
//

import Foundation
import RxSwift

protocol AuthApi {
    func login(username: String, password: String) -> Single<LoginResponse>
    func logout() -> Single<LogoutResponse>
}
