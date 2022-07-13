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
    typealias Dependencies = HasNetworkService & HasDatabaseService & HasCacheService
    
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
        fetchRecommendedItems()
    }

    func addToFavorites() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        let animeModel = AnimeModel(value: state.animeModel)
        dependencies.databaseService.addObject(object: animeModel)

        state.isFavorite = dependencies.databaseService.objectIsContained(id: state.animeModel.id)
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

    func backButtonTapped() {
        output?.animeDetailsBackButtonEventTriggered()
    }

    func cellTappedEventTriggered(with indexPath: IndexPath) {
        let id = state.recommendationsModels[indexPath.row].id
        dependencies.networkService.fetchAnimeById(id: id) { result, error in
            if let _ = error {
                return
            }
            guard let result = result else {
                return
            }
            self.output?.animeDetailsRecommendationCellEventTriggered(animeInfo: result.data)
        }
    }

    func fetchRecommendedItems() {
        dependencies.networkService.fetchRecommendationsList(id: state.animeModel.id) { result, error in
            if let _ = error {
                return
            }
            guard let result = result else {
                return
            }
            self.state.recommendationsModels = result.data.map { RecommendationsCellModel(recommendedItem: $0, presenter: self) }
            self.update(force: false, animated: true)
        }
    }

    // MARK: - Private

    private func fetchImage() {
        let url = state.animeModel.largeImageUrl
        dependencies.networkService.fetchImage(url: url) { image in
            self.state.image = image
            self.update(force: false, animated: true)
        }
    }

    private func updateState() {
        let genres = state.animeModel.genres
        state.genres = genres.joined(separator: ", ")
        let id = state.animeModel.id
        state.isFavorite = dependencies.databaseService.objectIsContained(id: id)
    }
}

// MARK: - AnimeDetailsModuleInput

extension AnimeDetailsPresenter: AnimeDetailsModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }
}
