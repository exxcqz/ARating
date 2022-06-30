//
//  TopListCellModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class TopListCellModel {
    var image: UIImage?
    var url: String
    var title: String
    var year: Int
    var rating: Double
    var presenter: TopListPresenter

    init(url: String, title: String, year: Int, rating: Double, presenter: TopListPresenter) {
        self.url = url
        self.title = title
        self.year = year
        self.rating = rating
        self.presenter = presenter
        fetchImage()
    }

    private func fetchImage() {
        presenter.dependencies.networkService.fetchImage(url: url) { result in
            self.image = result
        }
    }
}
