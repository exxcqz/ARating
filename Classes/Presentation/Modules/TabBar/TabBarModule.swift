//
//  MoviesModule.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

protocol TabBarModuleOutput {
    func tabBarDidSelect(navigationController: UINavigationController)
}

protocol TabBarModuleInput: AnyObject {
    var state: TabBarState { get }
    func update(force: Bool, animated: Bool)
}

final class TabBarModule {
    let viewController: TabBarController
    let presenter: TabBarPresenter
    let state: TabBarState

    var output: TabBarModuleOutput? {
        didSet {
            presenter.output = output
        }
    }

    var input: TabBarModuleInput {
        return presenter
    }

    init(state: TabBarState) {
        self.state = state
        let presenter = TabBarPresenter(state: state)
        let viewController = TabBarController(presenter: presenter)
        self.presenter = presenter
        self.viewController = viewController
    }
}
