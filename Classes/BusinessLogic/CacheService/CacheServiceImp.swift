//
//  CacheServiceImp.swift
//  ARating
//
//  Created by Nikita Gavrikov on 13.07.2022.
//

import UIKit

final class CacheServiceImp: CacheService {
    private var cache = NSCache<AnyObject, AnyObject>()

    func setObject(image: UIImage, forKey key: String) {
        cache.setObject(image as AnyObject, forKey: key as AnyObject)
    }

    func getObject(forKey key: String) -> UIImage? {
        let object = cache.object(forKey: key as AnyObject)
        return object as? UIImage
    }

    func removeAllObjects() {
        cache.removeAllObjects()
    }
}
