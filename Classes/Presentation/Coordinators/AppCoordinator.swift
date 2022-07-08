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
        let bookmarksModule = createBookmarksModule()

        let tabBarItems: [TabBarCellModel] = [
            TabBarCellModel(viewController: moviesModule.viewController, image: Asset.icTop.image, title: L10n.Tabbar.Top.title),
            TabBarCellModel(viewController: UIViewController(), image: Asset.icSearch.image, title: L10n.Tabbar.Search.title),
            TabBarCellModel(viewController: bookmarksModule.viewController, image: Asset.icBookmark.image, title: L10n.Tabbar.Bookmarks.title)
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

    private func createBookmarksModule() -> BookmarksModule {
        let module = BookmarksModule()
        module.output = self
        return module
    }

    private func createAnimeDetailsModule(animeInfo: AnimeInfo) -> AnimeDetailsModule {
        let state = AnimeDetailsState(animeInfo: animeInfo)
        let module = AnimeDetailsModule(state: state)
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

    func topListCellTappedEventTriggered(_ moduleInput: TopListModuleInput, animeInfo: AnimeInfo) {
        let animeDetailsModule = createAnimeDetailsModule(animeInfo: animeInfo)
        rootViewController.pushViewController(animeDetailsModule.viewController, animated: false)
    }
}

extension AppCoordinator: AnimeDetailsModuleOutput {

    func animeDetailsSynopsisTappedEventTriggered(synopsis: String) {
        rootViewController.pushViewController(SynopsisViewController(synopsis: synopsis), animated: true)
    }

    func moviesTappedEventTriggered(_ moduleInput: AnimeDetailsModuleInput) {

    }
}

extension AppCoordinator: BookmarksModuleOutput {

    func bookmarksCellTappedEventTriggered(_ moduleInput: BookmarksModuleInput, animeInfo: AnimeInfo) {
        let animeDetailsModule = createAnimeDetailsModule(animeInfo: animeInfo)
        rootViewController.pushViewController(animeDetailsModule.viewController, animated: false)
    }
}
