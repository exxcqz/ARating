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
}

// MARK: - MoviesModuleInput

extension TabBarPresenter: TabBarModuleInput {

    func update(force: Bool, animated: Bool) {

    }
}
