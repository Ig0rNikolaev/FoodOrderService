//
//  NetworkError.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 10.07.2023.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case errorURL
    case urlSession(URLError?)
    case errorResponse(Int)
    case decoding(DecodingError?)
    case unknown

    var description: String {
        switch self {
        case .errorURL:
            return "Ошибка адреса URL"
        case .urlSession(let error):
            return "Ошибка сеанса адреса URL: \(error.debugDescription)"
        case .errorResponse(let statusCode):
            return "Ошибка ответа. Код ошибки: \(statusCode)"
        case .decoding(let decodingError):
            return "Ошибка декодирования: \(String(describing: decodingError))"
        case .unknown:
            return "Неизвестная ошибка"
        }
    }

    var localizedDescription: String {
        switch self {
        case .errorURL, .unknown:
            return "Ошибка: что-то пошло не так"
        case .urlSession(let uRLError):
            return uRLError?.localizedDescription ?? "Ошибка: что-то пошло не так"
        case .errorResponse(_):
            return "Ошибка: что-то пошло не так"
        case .decoding(let decodingError):
            return decodingError?.localizedDescription ?? "Ошибка: что-то пошло не так"
        }
    }
}
