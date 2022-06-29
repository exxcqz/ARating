//
//  AppCoordinator.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator<UINavigationController> {

    private var window: UIWindow?
    private var tabBarModule: TabBarModule?

    init() {
        let navigationController = UINavigationController()
        super.init(rootViewController: navigationController)
    }

    func start(with scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        openTabBarModule()
    }

    private func openTabBarModule() {
        let tabBarModule = TabBarModule()
        tabBarModule.output = self
        rootViewController.pushViewController(tabBarModule.viewController, animated: true)
    }
}

// MARK: - TabBarModuleOutput

extension AppCoordinator: TabBarModuleOutput {

    func moviesTappedEventTriggered(_ moduleInput: TabBarModuleInput) {

    }
}
