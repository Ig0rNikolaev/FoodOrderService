//
//  NetworkService.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 10.07.2023.
//

import Foundation
import UIKit

struct NetworkService {
    static let shared = NetworkService(); private init() {}

    func fetchAllDishes(completion: @escaping(Result<AllDishes, NetworkError>) -> Void) {
        let url = createURL(scheme: "https", host: "yummie.glitch.me", path: .allCategorise)
        reqest(url: url, method: .get, completion: completion)
    }

    func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Dish], NetworkError>) -> Void) {
        let url = createURL(scheme: "https", host: "yummie.glitch.me", path: .fetchCategoryDishes(categoryId))
        reqest(url: url, method: .get, completion: completion)
    }

    func placeOrder(dishID: String, name: String, completion: @escaping(Result<Order, NetworkError>) -> Void) {
        let url = createURL(scheme: "https", host: "yummie.glitch.me", path: .placeOrder(dishID))
        let params = ["name": name]
        reqest(url: url, method: .post, parametrs: params, completion: completion)
    }

    func reqest<T: Decodable>(url: URL?, method: Method, parametrs: [String: Any]? = nil, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let reqest = createReqest(url: url, method: method, parametrs: parametrs) else {
            completion(.failure(NetworkError.unknown))
            return
        }
        URLSession.shared.dataTask(with: reqest) { data, responce, error in
            var result: Result<Data, NetworkError>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? ""
                print(responseString)
            } else if let error = error {
                result = .failure(NetworkError.unknown)
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.handleResponce(result: result, completion: completion)
            }
        }.resume()
    }

    private func handleResponce<T: Decodable>(result: Result<Data, NetworkError>?, completion: (Result<T, NetworkError>)  -> Void) {
        guard let result = result else {
            completion(.failure(NetworkError.unknown))
            return
        }

        switch result {
        case .success(let data):
            guard let responce = try? JSONDecoder().decode(ApiResponce<T>.self, from: data) else {
                completion(.failure(NetworkError.unknown))
                return
            }
            if let error = responce.error {
                completion(.failure(NetworkError.unknown))
            }
            if let decodeData = responce.data {
                completion(.success(decodeData))
            } else {
                completion(.failure(NetworkError.unknown))
            }
        case .failure(_):
            completion(.failure(NetworkError.unknown))
        }
    }

    func createReqest(url: URL?, method: Method, parametrs: [String: Any]? = nil) -> URLRequest? {
        guard let url = url else { return nil }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue

        if let parameters = parametrs {
            switch method {
            case .get:
                var urlComponents = URLComponents(string: "\(url)")
                urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponents?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }

    func createURL(scheme: String, host: String, path: Route) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path.description
        return components.url
    }
}

struct CreatureImageURL {
    static let shared = CreatureImageURL(); private init() {}
    func getDataImage(urlRequest: String?, imageFood: UIImageView) {
        guard let urlString = urlRequest, let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageFood.image = image
                }
            }
        }.resume()
    }
}
