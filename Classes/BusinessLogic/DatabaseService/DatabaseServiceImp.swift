//
//  DatabaseServiceImp.swift
//  ARating
//
//  Created by Nikita Gavrikov on 07.07.2022.
//

import Foundation
import RealmSwift

final class DatabaseServiceImp: DatabaseService {

    private let realm = try! Realm()

    func addObject(object: AnimeModel) {
        if objectIsContained(id: object.id) {
            removeObject(object: object)
        }
        else {
            try! realm.write {
                realm.add(object)
            }
        }
    }

    func removeObject(object: AnimeModel) {
        let objects = realm.objects(AnimeModel.self)
        let objectForDelete = objects.where { $0.id == object.id }
        try! realm.write {
            realm.delete(objectForDelete)
        }
    }

    func getAllObjects() -> [AnimeModel] {
        let objects = realm.objects(AnimeModel.self)
        return objects.reversed()
    }

    func objectIsContained(id: Int) -> Bool {
        let objects = realm.objects(AnimeModel.self)
        let result = objects.where { $0.id == id }
        return !result.isEmpty
    }
}
