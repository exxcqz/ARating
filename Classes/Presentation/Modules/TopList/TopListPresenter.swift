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
    var dependencies: Dependencies

    init(state: TopListState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }

    func fetchItems() {
        if !state.isEventScroll {
            dependencies.networkService.fetchTopListItems(page: state.currentPage) { result, error in
                if let _ = error {
                    return
                }
                guard let result = result else {
                    return
                }
                for item in result.data {
                    let model = TopListCellModel(url: item.images.jpg.imageUrl,
                                                 title: item.title ?? "",
                                                 year: item.year ?? 0,
                                                 rating: item.score ?? 0,
                                                 presenter: self)
                    self.state.items.append(model)
                }
                self.state.currentPage += 1
                self.state.totalPage = result.pagination.lastVisiblePage
                self.update(force: false, animated: true)
            }
            state.isEventScroll = true
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                self.state.isEventScroll = false
            }
        }
    }
}

// MARK: - MoviesModuleInput

extension TopListPresenter: TopListModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }
}
