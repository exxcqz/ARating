//
//  MoviesPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation
import UIKit

final class TopListPresenter {

    typealias Dependencies = HasNetworkService

    var view: TopListViewInput?
    var output: TopListModuleOutput?

    var state: TopListState
    private var dependencies: Dependencies

    init(state: TopListState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }

    func fetchItems(page: Int) {
        dependencies.networkService.fetchTopListItems(page: 1) { result, error in
            if let _ = error {
                return
            }
            guard let result = result else {
                return
            }
            let items = result.data
            self.state.items = items.map { item in
                TopListCellModel(image: Asset.test.image, title: item.title ?? "", year: item.year ?? 0, rating: item.score ?? 0)
            }
            self.view?.update(with: self.state, force: false, animated: true)
        }
    }
}

// MARK: - MoviesModuleInput

extension TopListPresenter: TopListModuleInput {

    func update(force: Bool, animated: Bool) {

    }
}
