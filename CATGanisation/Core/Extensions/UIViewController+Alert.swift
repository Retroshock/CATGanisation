//
//  UIViewController+Alert.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 16.09.2021.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(with message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
