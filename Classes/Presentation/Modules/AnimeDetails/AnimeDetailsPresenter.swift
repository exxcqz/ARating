//
//  AnimeDetailsPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import Foundation
import UIKit

final class AnimeDetailsPresenter {
    typealias Dependencies = HasNetworkService
    
    var view: AnimeDetailsViewInput?
    var output: AnimeDetailsModuleOutput?

    var state: AnimeDetailsState
    var dependencies: Dependencies

    init(state: AnimeDetailsState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }

    func viewDidLoad() {
        updateGenresLabel()
        fetchImage()
    }

    func addToFavorites() {
        state.animeModel.isFavorite.toggle()
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        update(force: false, animated: true)
    }

    // MARK: - Private

    private func fetchImage() {
        let url = state.animeModel.animeInfo.images.jpg.largeImageUrl
        dependencies.networkService.fetchImage(url: url) { image in
            self.state.image = image
            self.update(force: false, animated: true)
        }
    }

    private func updateGenresLabel() {
        let genres = state.animeModel.animeInfo.genres.map { $0.name }
        state.genres = genres.joined(separator: ", ")
    }
}

// MARK: - AnimeDetailsModuleInput

extension AnimeDetailsPresenter: AnimeDetailsModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }
}
