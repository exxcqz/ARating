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
        presenter.dependencies.networkService.fetchImage(url: imageUrl) { result in
            self.image = result
        }
    }
}
