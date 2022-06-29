//
//  SceneDelegate.swift
//  ARating
//
//  Created by Nikita Gavrikov on 28.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private lazy var appCoordinator: AppCoordinator = .init()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = (scene as? UIWindowScene) {
            appCoordinator.start(with: scene)
        }
    }
}

