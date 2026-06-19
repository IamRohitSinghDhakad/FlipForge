//
//  NetworkManager.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import SwiftUI
import Combine


protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    func urlRequest() throws -> URLRequest
}

extension Endpoint {
    func urlRequest() throws -> URLRequest {
        // build URLRequest with URLComponents or HTTPBody
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        // Attach parameters for GET or POST
        if let params = parameters {
            if method == .get {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = components?.url
            } else {
                request.httpBody = try JSONSerialization.data(withJSONObject: params)
            }
        }
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}

enum NetworkError: Error, LocalizedError {
    case invalidResponse, decodingFailed, clientError(Int), serverError(Int), unknownError(Int)
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid response from server."
        case .decodingFailed: return "Failed to decode data."
        case .clientError(let code): return "Client error (\(code))."
        case .serverError(let code): return "Server error (\(code))."
        case .unknownError(let code): return "Unknown error (\(code))."
        }
    }
}

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    private let session: URLSession
    private init(session: URLSession = .shared) {
        self.session = session
    }
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        switch http.statusCode {
        case 200...299: break
        case 400...499: throw NetworkError.clientError(http.statusCode)
        case 500...599: throw NetworkError.serverError(http.statusCode)
        default: throw NetworkError.unknownError(http.statusCode)
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

protocol NetworkManaging {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}
