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

    func fetchNewPage() {
        if state.searchModeActivated {
            fetchSearchItems()
        }
        else {
            fetchItems()
        }
    }

    func searchButtonTapped(query: String) {
        state.currentPage = 1
        state.items = []
        state.query = query
        state.searchModeActivated = true
        fetchSearchItems()
    }

    func cancelButtonTapped() {
        state.currentPage = 1
        state.items = []
        state.query = ""
        state.searchModeActivated = false
        fetchItems()
    }

    func fetchSearchItems() {
        dependencies.networkService.fetchSearchItems(query: state.query, page: state.currentPage) { result, error in
            if let _ = error {
                return
            }
            guard let result = result else {
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
