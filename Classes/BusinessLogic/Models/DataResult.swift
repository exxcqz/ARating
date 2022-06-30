//
//  Result.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

struct DataResult: Codable {
    let pagination: PageInfo
    let data: [AnimeInfo]
}
