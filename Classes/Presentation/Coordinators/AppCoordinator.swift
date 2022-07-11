//
//  AppCoordinator.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator<UINavigationController> {

    private var window: UIWindow?
    private var bookmarksModule: BookmarksModule?

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
        self.bookmarksModule = bookmarksModule

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

    private func createAnimeDetailsModule(animeModel: AnimeModel) -> AnimeDetailsModule {
        let state = AnimeDetailsState(animeModel: animeModel)
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
        let animeModel = AnimeModel(animeInfo: animeInfo)
        let animeDetailsModule = createAnimeDetailsModule(animeModel: animeModel)
        rootViewController.pushViewController(animeDetailsModule.viewController, animated: false)
    }
}

extension AppCoordinator: AnimeDetailsModuleOutput {

    func animeDetailsTappedEventTriggered(_ moduleInput: AnimeDetailsModuleInput) {
    }

    func animeDetailsSynopsisTappedEventTriggered(synopsis: String) {
        rootViewController.pushViewController(SynopsisViewController(synopsis: synopsis), animated: true)
    }

    func animeDetailsBackButtonEventTriggered() {
        rootViewController.popViewController(animated: true)
        bookmarksModule?.input.updateCollectionView()
    }
}

extension AppCoordinator: BookmarksModuleOutput {

    func bookmarksCellTappedEventTriggered(_ moduleInput: BookmarksModuleInput, animeModel: AnimeModel) {
        let animeDetailsModule = createAnimeDetailsModule(animeModel: animeModel)
        rootViewController.pushViewController(animeDetailsModule.viewController, animated: false)
    }
}
