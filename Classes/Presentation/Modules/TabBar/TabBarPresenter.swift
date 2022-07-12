//
//  MoviesPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class TabBarPresenter {
    var view: TabBarViewInput?
    var output: TabBarModuleOutput?

    var state: TabBarState

    init(state: TabBarState) {
        self.state = state
        loadViewControllers()
    }

    private func loadViewControllers() {
        state.viewControllers = state.items.map {
            createNavController(for: $0.viewController,
                                   title: $0.title,
                                   image: $0.image,
                                   tag: $0.tag)
        }
    }

    func didSelect(index: Int) {
        let navController = state.viewControllers[index]
        output?.tabBarDidSelect(controller: navController)
    }

    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage,
                                     tag: Int) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.tag = tag
        rootViewController.navigationItem.title = title
        return navController
    }
}

// MARK: - MoviesModuleInput

extension TabBarPresenter: TabBarModuleInput {

    func update(force: Bool, animated: Bool) {

    }
}
