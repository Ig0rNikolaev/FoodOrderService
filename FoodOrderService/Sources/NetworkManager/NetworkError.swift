//
//  NetworkError.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 10.07.2023.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case decoding(DecodingError?)
    case unknown

    var description: String {
        switch self {
        case .decoding(let decodingError):
            return "Ошибка декодирования: \(String(describing: decodingError))"
        case .unknown:
            return "Неизвестная ошибка"
        }
    }

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Ошибка: что-то пошло не так"
        case .decoding(let decodingError):
            return decodingError?.localizedDescription ?? "Ошибка: что-то пошло не так"
        }
    }
}
