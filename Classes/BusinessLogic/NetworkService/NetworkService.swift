//
//  NetworkService.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

protocol HasNetworkService {
    var networkService: NetworkService { get }
}

protocol NetworkService: AnyObject {
    func fetchTopListItems(page: Int, response: @escaping (DataResult?, Error?) -> Void)
    func fetchImage(url: String, completion: @escaping (UIImage) -> Void)
}
