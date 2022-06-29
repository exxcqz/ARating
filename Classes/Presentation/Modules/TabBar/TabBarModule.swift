//
//  MoviesModule.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

protocol TabBarModuleOutput {
    func moviesTappedEventTriggered(_ moduleInput: TabBarModuleInput)
}

protocol TabBarModuleInput: AnyObject {
    var state: TabBarState { get }
    func update(force: Bool, animated: Bool)
}

final class TabBarModule {
    let viewController: TabBarViewController
    let presenter: TabBarPresenter

    var output: TabBarModuleOutput? {
        didSet {
            presenter.output = output
        }
    }

    var input: TabBarModuleInput {
        return presenter
    }

    init(state: TabBarState = .init()) {
        let presenter = TabBarPresenter(state: state)
        let viewController = TabBarViewController(presenter: presenter)
        presenter.view = viewController
        self.presenter = presenter
        self.viewController = viewController
    }
}
