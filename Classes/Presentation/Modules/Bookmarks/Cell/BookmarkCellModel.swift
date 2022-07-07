//
//  BookmarksCellModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 07.07.2022.
//

import UIKit

final class BookmarkCellModel {
    var image: UIImage?
    var animeModel: AnimeModel
    var title: String
    var year: Int
    var rating: Double
    var isFavorite: Bool = false
    var presenter: BookmarksPresenter

    init(animeModel: AnimeModel, presenter: BookmarksPresenter) {
        self.animeModel = animeModel
        self.presenter = presenter
        self.title = animeModel.englishTitle ?? animeModel.title ?? ""
        self.year = animeModel.year ?? 0
        self.rating = animeModel.score ?? 0
        fetchImage()
    }

    private func fetchImage() {
        let imageUrl = animeModel.imageUrl
        presenter.dependencies.networkService.fetchImage(url: imageUrl) { result in
            self.image = result
        }
    }
}
