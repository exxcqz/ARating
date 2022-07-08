//
//  AnimeDetailsPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import Foundation
import UIKit
import RealmSwift

final class AnimeDetailsPresenter {
    typealias Dependencies = HasNetworkService & HasDatabaseService
    
    var view: AnimeDetailsViewInput?
    var output: AnimeDetailsModuleOutput?

    var state: AnimeDetailsState
    var dependencies: Dependencies

    init(state: AnimeDetailsState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }

    func viewDidLoad() {
        updateState()
        fetchImage()
    }

    func addToFavorites() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        let databaseModel = AnimeModel(animeInfo: state.animeInfo)
        dependencies.databaseService.addObject(object: databaseModel)

        state.isFavorite = dependencies.databaseService.objectIsContained(id: state.animeInfo.id)
        update(force: false, animated: true)
    }

    func presentSynopsisViewController() {
        output?.animeDetailsSynopsisTappedEventTriggered(synopsis: state.synopsis)
    }

    func showNavigationBar(isHidden: Bool) {
        state.isNavigationBarHidden = isHidden
        update(force: false, animated: true)
    }

    func updateImageViewScale(scale: CGFloat) {
        state.imageViewScale = scale
        update(force: false, animated: true)
    }

    // MARK: - Private

    private func fetchImage() {
        let url = state.animeInfo.images.jpg.largeImageUrl
        dependencies.networkService.fetchImage(url: url) { image in
            self.state.image = image
            self.update(force: false, animated: true)
        }
    }

    private func updateState() {
        let genres = state.animeInfo.genres.map { $0.name }
        state.genres = genres.joined(separator: ", ")
        let id = state.animeInfo.id
        state.isFavorite = dependencies.databaseService.objectIsContained(id: id)
    }
}

// MARK: - AnimeDetailsModuleInput

extension AnimeDetailsPresenter: AnimeDetailsModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }
}