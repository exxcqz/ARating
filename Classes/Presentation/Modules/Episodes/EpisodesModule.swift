//
//  EpisodesModule.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import Foundation

protocol EpisodesModuleOutput {
}

protocol EpisodesModuleInput: AnyObject {
    var state: EpisodesState { get }
    func update(force: Bool, animated: Bool)
}

final class EpisodesModule {
    let viewController: EpisodesViewController
    let presenter: EpisodesPresenter
    let state: EpisodesState

    var output: EpisodesModuleOutput? {
        didSet {
            presenter.output = output
        }
    }

    var input: EpisodesModuleInput {
        return presenter
    }

    init(state: EpisodesState) {
        self.state = state
        let presenter = EpisodesPresenter(state: state, dependencies: Services)
        let viewController = EpisodesViewController(presenter: presenter)
        presenter.view = viewController
        self.presenter = presenter
        self.viewController = viewController
    }
}
