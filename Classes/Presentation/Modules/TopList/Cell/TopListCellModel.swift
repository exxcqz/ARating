//
//  TopListCellModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class TopListCellModel {
    var image: UIImage?
    var animeInfo: AnimeInfo
    var title: String
    var year: Int
    var rating: Double
    var isFavorite: Bool = false
    var presenter: TopListPresenter

    init(animeInfo: AnimeInfo, presenter: TopListPresenter) {
        self.animeInfo = animeInfo
        self.presenter = presenter
        self.title = animeInfo.englishTitle ?? animeInfo.title ?? ""
        self.year = animeInfo.year ?? 0
        self.rating = animeInfo.score ?? 0
        fetchImage()
    }

    private func fetchImage() {
        let imageUrl = animeInfo.images.jpg.imageUrl
        if let image = presenter.dependencies.cacheService.getObject(forKey: imageUrl) {
            self.image = image
            return
        }
        presenter.dependencies.networkService.fetchImage(url: imageUrl) { [weak self] result in
            self?.image = result
        }
    }
}
