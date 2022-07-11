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
        let animeModel = state.items[indexPath.row].animeModel
        output?.bookmarksCellTappedEventTriggered(self, animeModel: animeModel)
    }

    private func fetchItems() {
        let animeModels = dependencies.databaseService.getAllObjects()
        state.items = animeModels.map { BookmarkCellModel(animeModel: $0, presenter: self) }
        update(force: false, animated: true)
    }
}

// MARK: - BookmarksModuleInput

extension BookmarksPresenter: BookmarksModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }

    func updateCollectionView() {
        fetchItems()
    }
}
