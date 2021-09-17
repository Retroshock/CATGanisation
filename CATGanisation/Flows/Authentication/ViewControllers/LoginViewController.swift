//
//  LoginViewController.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 13.09.2021.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func didLogin()
}

class LoginViewController: BaseViewController<LoginViewModel> {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    enum Validation {
        case password(String)
        case username(String)
        case ok
    }

    private var coordinator: LoginCoordinatorProtocol {
        coordinatorProtocol as! LoginCoordinatorProtocol
    }

    func configure(with viewModel: LoginViewModel, delegate: LoginCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinatorProtocol = delegate
    }

    @IBAction private func didPressLogin(_ sender: UIButton) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else {
            return
        }
        let validation = validateFields(username: username, password: password)
        switch validation {
        case .ok:
            LoaderView.show()
            viewModel.login(username: username, password: password).subscribe { [weak self] isLoggedIn in
                LoaderView.hide()
                if isLoggedIn {
                    self?.coordinator.didLogin()
                }
            } onFailure: { [weak self] error in
                LoaderView.hide()
                // TODO: Remove on proper implementation of login
                self?.viewModel.authService.isLoggedIn.accept(true)
                self?.coordinator.didLogin()
//                self?.showSimpleAlert(with: error.localizedDescription)
            }
            .disposed(by: disposeBag)
        case let .password(message):
            showSimpleAlert(with: message)
        case let .username(message):
            showSimpleAlert(with: message)
        }
    }

    func validateFields(username: String, password: String) -> Validation {
        if username.isEmpty {
            return .username("Username cannot be empty")
        }
        if password.isEmpty {
            return .password("Password cannot be empty")
        }
        if password.count < 8 {
            return .password("Password must have at least 8 characters")
        }
        return .ok
    }

}
