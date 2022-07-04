//
//  AnimeDetailsModule.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import Foundation

protocol AnimeDetailsModuleOutput {
    func moviesTappedEventTriggered(_ moduleInput: AnimeDetailsModuleInput)
    func animeDetailsSynopsisTappedEventTriggered(synopsis: String)
}

protocol AnimeDetailsModuleInput: AnyObject {
    var state: AnimeDetailsState { get }
    func update(force: Bool, animated: Bool)
}

final class AnimeDetailsModule {
    let viewController: AnimeDetailsViewController
    let presenter: AnimeDetailsPresenter

    var output: AnimeDetailsModuleOutput? {
        didSet {
            presenter.output = output
        }
    }

    var input: AnimeDetailsModuleInput {
        return presenter
    }

    init(state: AnimeDetailsState) {
        let presenter = AnimeDetailsPresenter(state: state, dependencies: Services)
        let viewController = AnimeDetailsViewController(presenter: presenter)
        presenter.view = viewController
        self.presenter = presenter
        self.viewController = viewController
    }
}
