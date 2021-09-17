//
//  LoginViewModel.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 13.09.2021.
//

import Foundation
import RxSwift

class LoginViewModel: BaseViewModel {
    let authService = resolve(AuthService.self)

    func login(username: String, password: String) -> Single<Bool> {
        authService.login(username: username, password: password)
    }
}
