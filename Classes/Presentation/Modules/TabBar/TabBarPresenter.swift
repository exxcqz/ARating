//
//  MoviesPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

final class TabBarPresenter {
    var view: TabBarViewInput?
    var output: TabBarModuleOutput?

    var state: TabBarState

    init(state: TabBarState) {
        self.state = state
    }

    func didSelectCell(with indexPath: IndexPath) {
        state.selectedCell = indexPath.row
        state.embeddedView = state.items[indexPath.row].viewController.view
        view?.update(with: state, force: false, animated: true)
    }

    func viewDidLoad() {
        state.embeddedView = state.items[state.selectedCell].viewController.view
        view?.update(with: state, force: false, animated: true)
    }
}

// MARK: - MoviesModuleInput

extension TabBarPresenter: TabBarModuleInput {

    func update(force: Bool, animated: Bool) {

    }
}
