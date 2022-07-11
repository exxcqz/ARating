//
//  BookmarksModule.swift
//  ARating
//
//  Created by Nikita Gavrikov on 07.07.2022.
//

import Foundation

protocol BookmarksModuleOutput {
    func bookmarksCellTappedEventTriggered(_ moduleInput: BookmarksModuleInput, animeModel: AnimeModel)
}

protocol BookmarksModuleInput: AnyObject {
    var state: BookmarksState { get }
    func update(force: Bool, animated: Bool)
    func updateCollectionView()
}

final class BookmarksModule {
    let viewController: BookmarksViewController
    let presenter: BookmarksPresenter

    var output: BookmarksModuleOutput? {
        didSet {
            presenter.output = output
        }
    }

    var input: BookmarksModuleInput {
        return presenter
    }

    init(state: BookmarksState = .init()) {
        let presenter = BookmarksPresenter(state: state, dependencies: Services)
        let viewController = BookmarksViewController(presenter: presenter)
        presenter.view = viewController
        self.presenter = presenter
        self.viewController = viewController
    }
}
