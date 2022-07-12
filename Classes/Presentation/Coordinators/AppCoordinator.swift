//
//  AppCoordinator.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class AppCoordinator {

    private var window: UIWindow?
    private var bookmarksModule: BookmarksModule?
    private var rootViewController: UINavigationController?

    func start(with scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        let tabBarModule = createTabBarModule()
        rootViewController = tabBarModule.state.viewControllers.first
        window?.rootViewController = tabBarModule.viewController
        window?.makeKeyAndVisible()
    }

    private func createTabBarModule() -> TabBarModule {
        let moviesModule = createTopListModule()
        let bookmarksModule = createBookmarksModule()
        self.bookmarksModule = bookmarksModule

        let tabBarItems: [TabBarModel] = [
            TabBarModel(viewController: moviesModule.viewController, image: Asset.icTop.image, title: L10n.Tabbar.Top.title, tag: 0),
            TabBarModel(viewController: UIViewController(), image: Asset.icSearch.image, title: L10n.Tabbar.Search.title, tag: 1),
            TabBarModel(viewController: bookmarksModule.viewController, image: Asset.icBookmark.image, title: L10n.Tabbar.Bookmarks.title, tag: 2)
        ]
        let tabBarModule = TabBarModule(state: TabBarState(items: tabBarItems))
        tabBarModule.output = self
        return tabBarModule
    }

    private func createTopListModule() -> TopListModule {
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

    func tabBarDidSelect(controller: UINavigationController) {
        rootViewController = controller
    }
}

extension AppCoordinator: TopListModuleOutput {

    func topListCellTappedEventTriggered(_ moduleInput: TopListModuleInput, animeInfo: AnimeInfo) {
        let animeModel = AnimeModel(animeInfo: animeInfo)
        let animeDetailsModule = createAnimeDetailsModule(animeModel: animeModel)
        rootViewController?.pushViewController(animeDetailsModule.viewController, animated: false)
    }
}

extension AppCoordinator: AnimeDetailsModuleOutput {

    func animeDetailsTappedEventTriggered(_ moduleInput: AnimeDetailsModuleInput) {
    }

    func animeDetailsSynopsisTappedEventTriggered(synopsis: String) {
        rootViewController?.pushViewController(SynopsisViewController(synopsis: synopsis), animated: true)
    }

    func animeDetailsBackButtonEventTriggered() {
        rootViewController?.popViewController(animated: true)
        bookmarksModule?.input.updateCollectionView()
    }

    func animeDetailsRecommendationCellEventTriggered(animeInfo: AnimeInfo) {
        let animeModel = AnimeModel(animeInfo: animeInfo)
        let animeDetailsModule = createAnimeDetailsModule(animeModel: animeModel)
        rootViewController?.pushViewController(animeDetailsModule.viewController, animated: false)
    }
}

extension AppCoordinator: BookmarksModuleOutput {

    func bookmarksCellTappedEventTriggered(_ moduleInput: BookmarksModuleInput, animeModel: AnimeModel) {
        let animeDetailsModule = createAnimeDetailsModule(animeModel: animeModel)
        rootViewController?.pushViewController(animeDetailsModule.viewController, animated: false)
    }
}
