//
//  BookmarksPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 07.07.2022.
//

import Foundation
import UIKit

final class BookmarksPresenter {

    typealias Dependencies = HasNetworkService & HasDatabaseService

    var view: BookmarksViewInput?
    var output: BookmarksModuleOutput?

    var state: BookmarksState
    var dependencies: Dependencies

    init(state: BookmarksState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }

    func viewDidLoad() {
        fetchItems()
    }

    func cellTappedEventTriggered(with indexPath: IndexPath) {
        let id = state.items[indexPath.row].animeModel.id
        fetchAnimeInfo(with: id)
    }

    private func fetchItems() {
        let animeModels = dependencies.databaseService.getAllObjects()
        state.items = animeModels.map { BookmarkCellModel(animeModel: $0, presenter: self) }
        update(force: false, animated: true)
    }

    private func fetchAnimeInfo(with id: Int) {
        dependencies.networkService.fetchAnimeById(id: id) { result, error in
            if let _ = error {
                return
            }

            if let result = result {
                self.output?.bookmarksCellTappedEventTriggered(self, animeInfo: result.data)
            }
        }
    }
}

// MARK: - MoviesModuleInput

extension BookmarksPresenter: BookmarksModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }
}
