//
//  AppCoordinator.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import RxSwift
import UIKit

class AppCoordinator: Coordinator {
    let disposeBag = DisposeBag()

    var endFlow: (() -> Void)? = nil

    let authService = resolve(AuthService.self)
    var children: [Coordinator] = []

    let navigationController: UINavigationController

    required init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        start()
    }

    func start() {
        NFX.sharedInstance().start()
        authService.isLoggedIn.distinctUntilChanged().observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoggedIn in
            guard let self = self else { return }
//            if isLoggedIn {
                self.showBreeds()
//            } else {
//                self.showLogin()
//            }
        }).disposed(by: disposeBag)
    }

    func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
        loginCoordinator.endFlow = { [weak self] in
            self?.finishedChildFlow(flow: loginCoordinator)
        }
        addChildCoordinator(loginCoordinator)
    }

    func showBreeds() {
        let breedsCoordinator = BreedsCoordinator(navigationController: navigationController)
        breedsCoordinator.start()
        breedsCoordinator.endFlow = { [weak self] in
            self?.finishedChildFlow(flow: breedsCoordinator)
        }
        addChildCoordinator(breedsCoordinator)
    }

    func finishedChildFlow(flow: Coordinator) {
        children.removeAll(where: { $0 === flow })
    }
}

