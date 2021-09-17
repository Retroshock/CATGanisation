//
//  StoryboardIdentifiable.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import UIKit

func instantiateViewController<T>(
    ofType type: T.Type,
    inStoryboard storyboardName: UIStoryboard.Name,
    identifier: String? = nil,
    config: (T) -> Void = { _ in }
) -> T {
    let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier ?? String(describing: type)) as? T else {
        preconditionFailure(
            "The controller doesn't have the identifier set to \(String(describing: type)) or it isn't in the storyboard named: \(storyboardName)"
        )
    }
    config(viewController)

    return viewController
}

extension UIStoryboard {
    enum Name: String {
        case main = "Main"
        case login = "Login"
        case breeds = "Breeds"
    }
}
