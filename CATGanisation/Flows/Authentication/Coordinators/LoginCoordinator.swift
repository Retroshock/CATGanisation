//
//  LoginCoordinator.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 13.09.2021.
//

import RxSwift
import UIKit

class LoginCoordinator: Coordinator {
    var children: [Coordinator] = []

    var endFlow: (() -> Void)?

    let disposeBag: DisposeBag = DisposeBag()

    let navigationController: UINavigationController

    required init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.setNavigationBarHidden(true, animated: true)
        let loginViewController = instantiateViewController(ofType: LoginViewController.self, inStoryboard: .login)
        loginViewController.configure(with: LoginViewModel(), delegate: self)
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func finishedChildFlow(flow: Coordinator) {
        
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    func didLogin() {
        // TODO: Show Kitty Dashboard
        endFlow?()
    }
}
