//
//  AnimeDetailsPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import Foundation

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
        fetchImage()
    }

    private func fetchImage() {
        let url = state.animeInfo.images.jpg.largeImageUrl
        dependencies.networkService.fetchImage(url: url) { image in
            self.state.image = image
            self.update(force: false, animated: true)
        }
    }
}

// MARK: - AnimeDetailsModuleInput

extension AnimeDetailsPresenter: AnimeDetailsModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }
}
