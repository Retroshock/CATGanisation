//
//  SceneDelegate.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        appCoordinator = AppCoordinator()
        window?.rootViewController = appCoordinator?.navigationController
    }

}

