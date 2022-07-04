//
//  MoviesModule.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

protocol TopListModuleOutput {
    func topListCellTappedEventTriggered(_ moduleInput: TopListModuleInput, animeModel: TopListCellModel)
}

protocol TopListModuleInput: AnyObject {
    var state: TopListState { get }
    func update(force: Bool, animated: Bool)
}

final class TopListModule {
    let viewController: TopListViewController
    let presenter: TopListPresenter

    var output: TopListModuleOutput? {
        didSet {
            presenter.output = output
        }
    }

    var input: TopListModuleInput {
        return presenter
    }

    init(state: TopListState = .init()) {
        let presenter = TopListPresenter(state: state, dependencies: Services)
        let viewController = TopListViewController(presenter: presenter)
        presenter.view = viewController
        self.presenter = presenter
        self.viewController = viewController
    }
}
