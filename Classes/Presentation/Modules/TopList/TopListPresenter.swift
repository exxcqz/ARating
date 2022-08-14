//
//  MoviesPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation
import UIKit

final class TopListPresenter {

    typealias Dependencies = HasNetworkService & HasCacheService

    var view: TopListViewInput?
    var output: TopListModuleOutput?

    var state: TopListState
    var dependencies: Dependencies

    init(state: TopListState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }

    func fetchTopItems() {
        if !state.isEventScroll {
            dependencies.networkService.fetchTopListItems(page: state.currentPage) { [weak self] result, error in
                if let _ = error {
                    return
                }
                guard let result = result, let self = self else {
                    return
                }
                for item in result.data {
                    let model = TopListCellModel(animeInfo: item, presenter: self)
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

    func cellTappedEventTriggered(with indexPath: IndexPath) {
        let model = state.items[indexPath.row]
        output?.topListCellTappedEventTriggered(self, animeInfo: model.animeInfo)
    }

    func fetchItems() {
        if state.searchModeActivated {
            fetchSearchItems()
        }
        else {
            fetchTopItems()
        }
    }

    func searchButtonTapped(query: String) {
        output?.topListSearchButtonEventTriggered(query: query)
    }

    func cancelButtonTapped() {
        output?.topListCancelButtonEventTriggered()
    }

    func fetchSearchItems() {
        dependencies.networkService.fetchSearchItems(query: state.query, page: state.currentPage) { [weak self] result, error in
            if let _ = error {
                return
            }
            guard let result = result, let self = self else {
                return
            }
            for item in result.data {
                let model = TopListCellModel(animeInfo: item, presenter: self)
                self.state.items.append(model)
            }
            self.state.currentPage += 1
            self.state.totalPage = result.pagination.lastVisiblePage
            self.update(force: false, animated: true)
        }
    }
}

// MARK: - MoviesModuleInput

extension TopListPresenter: TopListModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }
}
