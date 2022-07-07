//
//  DatabaseService.swift
//  ARating
//
//  Created by Nikita Gavrikov on 07.07.2022.
//

import Foundation

protocol HasDatabaseService {
    var databaseService: DatabaseService { get }
}

protocol DatabaseService {
    func addObject(object: AnimeModel)
    func removeObject(object: AnimeModel)
    func getAllObjects() -> [AnimeModel]
    func objectIsContained(id: Int) -> Bool
}
