//
//  EpisodesPresenter.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import Foundation

final class EpisodesPresenter {
    typealias Dependencies = HasNetworkService

    var view: EpisodesViewInput?
    var output: EpisodesModuleOutput?

    var state: EpisodesState
    var dependencies: Dependencies

    init(state: EpisodesState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }

    func viewDidLoad() {
        fetchEpisodes()
        update(force: false, animated: true)
    }

    func fetchEpisodes() {
        if state.currentPage <= state.totalPage {
            dependencies.networkService.fetchEpisodes(id: state.id, page: state.currentPage) { [weak self ] result, error in
                if let _ = error {
                    return
                }
                guard let result = result else {
                    return
                }
                let items = result.data.map { EpisodesCellModel(episodeModel: $0) }
                self?.state.items.append(contentsOf: items)
                self?.state.currentPage += 1
                self?.state.totalPage = result.pagination.totalPage
                self?.update(force: false, animated: true)
            }
        }
    }
}

// MARK: - EpisodesModuleInput

extension EpisodesPresenter: EpisodesModuleInput {

    func update(force: Bool, animated: Bool) {
        view?.update(with: state, force: force, animated: animated)
    }
}
