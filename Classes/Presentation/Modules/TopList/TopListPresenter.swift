//
//  MoviesPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

final class TopListPresenter {
    var view: TopListViewInput?
    var output: TopListModuleOutput?

    var state: TopListState

    init(state: TopListState) {
        self.state = state
    }
}

// MARK: - MoviesModuleInput

extension TopListPresenter: TopListModuleInput {

    func update(force: Bool, animated: Bool) {

    }
}
