//
//  BaseAPIClient.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import Alamofire
import Foundation
import RxSwift

enum APIEnvironment: String {
    case main = "https://api.thecatapi.com" // url here
}

enum APIError: Error {
    case badURL
    case unauthenticated
    case serverError
    case clientError
    case decodingError
    case unknown
    case noData

    static func getError(from code: Int?) -> APIError {
        guard let code = code else { return .unknown }
        switch code {
        case 401:
            return .unauthenticated
        case 402..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            return .unknown
        }
    }
}

class BaseAPIClient {
    private let httpClient: Session

    required init(_ sessionManager: Session) {
        self.httpClient = sessionManager
    }

    func call<T: Decodable>(
        method: HTTPMethod,
        endpoint: String,
        query: [String: Any]? = nil,
        env: APIEnvironment = .main,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default
    ) -> Single<T> {
        return Single.create { observer in
            guard let url = try? self.url(
                endpoint.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!,
                env: env
            ).asURL() else {
                observer(.failure(APIError.badURL))
                return Disposables.create()
            }

            let request = self.httpClient.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: [
                    "x-api-key": "46ca603c-3929-4854-b57c-39ffa22ebd5e"
                ] // Change if necessary
            )

            request.responseData { response in
                if let error = response.error {
                    observer(.failure(APIError.getError(from: error.responseCode)))
                } else {
                    guard let data = response.data else {
                        observer(.failure(APIError.noData)) // This is
                        return
                    }
                    guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                        observer(.failure(APIError.decodingError))
                        return
                    }
                    observer(.success(object))
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }

    private func url(_ path: String, env: APIEnvironment = .main) -> String {
        return env.rawValue.trimmingCharacters(in: ["/"]) + "/" + path.trimmingCharacters(in: ["/"])
    }
}
