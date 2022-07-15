//
//  EpisodesCellModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import Foundation

final class EpisodesCellModel {
    let id: Int
    let title: String?
    let aired: String?
    let score: Double?
    let filler: Bool

    init(episodeModel: EpisodeModel) {
        self.id = episodeModel.id
        self.title = episodeModel.title
        self.aired = episodeModel.aired
        self.score = episodeModel.score
        self.filler = episodeModel.filler
    }
}
 
