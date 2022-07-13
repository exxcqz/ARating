//
//  CacheService.swift
//  ARating
//
//  Created by Nikita Gavrikov on 13.07.2022.
//

import UIKit

protocol HasCacheService {
    var cacheService: CacheService { get }
}

protocol CacheService {
    func setObject(image: UIImage, forKey key: String)
    func getObject(forKey key: String) -> UIImage?
    func removeAllObjects()
}
