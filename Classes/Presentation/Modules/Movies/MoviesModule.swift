//
//  MoviesModule.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

protocol MoviesModuleOutput {
    func moviesTappedEventTriggered(_ moduleInput: MoviesModuleInput)
}

protocol MoviesModuleInput: AnyObject {
    var state: MoviesState { get }
    func update(force: Bool, animated: Bool)
}

final class MoviesModule {
    let viewController: MoviesViewController
    let presenter: MoviesPresenter

    var output: MoviesModuleOutput? {
        didSet {
            presenter.output = output
        }
    }

    var input: MoviesModuleInput {
        return presenter
    }

    init(state: MoviesState = .init()) {
        let presenter = MoviesPresenter(state: state)
        let viewController = MoviesViewController(presenter: presenter)
        presenter.view = viewController
        self.presenter = presenter
        self.viewController = viewController
    }
}
