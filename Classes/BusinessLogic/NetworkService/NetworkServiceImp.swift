//
//  NetworkServiceImp.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class NetworkServiceImp: NetworkService {

    func fetchTopListItems(page: Int, response: @escaping (DataResult?, Error?) -> Void) {
        let request = NetworkType.getTopList(page: page).request
        NetworkRequest.shared.requestData(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let dataResult = try JSONDecoder().decode(DataResult.self, from: data)
                    response(dataResult, nil)
                } catch let jsonError {
                    print("Failed decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error fetch data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }

    func fetchImage(url: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
        task.resume()
    }
}
