//
//  NetworkType.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

enum NetworkType {
    case getTopList(page: Int)
    case getSearch(query: String, page: Int)

    var baseURL: URL {
        return URL(string: "https://api.jikan.moe/v4/")!
    }

    var path: String {
        switch self {
        case .getSearch(let query, let page):
            var path = "top/anime"
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
                return path
            }
            path = "anime?q=\(query)&page=\(page)"
            return path
        case .getTopList(let page):
            return "top/anime?page=\(page)"
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        var request = URLRequest(url: url!)
        switch self {
        case .getSearch:
            request.httpMethod = "GET"
            return request
        case .getTopList:
            request.httpMethod = "GET"
            return request
        }
    }
}
