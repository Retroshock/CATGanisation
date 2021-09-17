//
//  AuthService.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import Foundation
import RxSwift
import RxRelay

class AuthService {
    let authApi = resolve(AuthApi.self)
    let isLoggedIn = BehaviorRelay<Bool>(value: false)

    func login(username: String, password: String) -> Single<Bool> {
        authApi.login(username: username, password: password).do(onSuccess: { [weak self] _ in
            // TODO: change token in keychain
            self?.isLoggedIn.accept(true)
        }, onError: { [weak self] error in
            self?.isLoggedIn.accept(true) // Change in the actual implementation
        })
        .flatMap { [weak self] _ in
            guard let self = self else { return .just(false) }
            return self.isLoggedIn.asSingle()
        }
    }

    func logout() -> Completable {
        authApi.logout()
            // No matter if the logout call is successful or not, we invalidate the token and logout the user
            .do(onSuccess: { [weak self] _ in
                self?.invalidateTokensAndLogout()
            }, onError: { [weak self] _ in
                self?.invalidateTokensAndLogout()
            })
            .asCompletable()
    }

    private func invalidateTokensAndLogout() {
        isLoggedIn.accept(false)
        // TODO: Remove token from keychain
    }
}
