//
//  RecommendationsCellModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 12.07.2022.
//

import UIKit

final class RecommendationsCellModel {
    var image: UIImage?
    var recommendationItem: RecommendationItem
    var id: Int
    var title: String
    var presenter: AnimeDetailsPresenter

    init(recommendedItem: RecommendationItem, presenter: AnimeDetailsPresenter) {
        self.recommendationItem = recommendedItem
        self.id = recommendedItem.entry.id
        self.title = recommendedItem.entry.title
        self.presenter = presenter
        fetchImage()
    }

    private func fetchImage() {
        let imageUrl = recommendationItem.entry.images.jpg.imageUrl
        if let image = presenter.dependencies.cacheService.getObject(forKey: imageUrl) {
            self.image = image
            return
        }
        presenter.dependencies.networkService.fetchImage(url: imageUrl) { [weak self] result in
            self?.image = result
            self?.presenter.dependencies.cacheService.setObject(image: result, forKey: imageUrl)
        }
    }
}
