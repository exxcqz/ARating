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
        let moviesModule = createMoviesModule()

        let tabBarItems: [TabBarCellModel] = [
            TabBarCellModel(viewController: moviesModule.viewController, image: Asset.icMovies.image, title: L10n.Tabbar.Top.title),
            TabBarCellModel(viewController: UIViewController(), image: Asset.icSearch.image, title: L10n.Tabbar.Search.title)
        ]
        let tabBarModule = TabBarModule(state: TabBarState(items: tabBarItems))
        tabBarModule.output = self
        rootViewController.pushViewController(tabBarModule.viewController, animated: true)
    }

    private func createMoviesModule() -> TopListModule {
        let module = TopListModule()
        module.output = self
        return module
    }
}

// MARK: - TabBarModuleOutput

extension AppCoordinator: TabBarModuleOutput {

    func moviesTappedEventTriggered(_ moduleInput: TabBarModuleInput) {

    }
}

extension AppCoordinator: TopListModuleOutput {

    func moviesTappedEventTriggered(_ moduleInput: TopListModuleInput) {

    }
}
