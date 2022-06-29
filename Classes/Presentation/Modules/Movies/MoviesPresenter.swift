//
//  MoviesPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

final class MoviesPresenter {
    var view: MoviesViewInput?
    var output: MoviesModuleOutput?

    var state: MoviesState

    init(state: MoviesState) {
        self.state = state
    }
}

// MARK: - MoviesModuleInput

extension MoviesPresenter: MoviesModuleInput {

    func update(force: Bool, animated: Bool) {

    }
}
