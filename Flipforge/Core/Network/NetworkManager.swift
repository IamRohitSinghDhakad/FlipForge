//
//  NetworkManager.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import SwiftUI
import Combine
import UIKit

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

        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )

        if let params = parameters {
            components?.queryItems = params.map {

                URLQueryItem(
                    name: $0.key,
                    value: "\($0.value)"
                )
            }
        }

        guard let finalURL = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
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
        print("\n================== API REQUEST ==================")
        print("URL       : \(request.url?.absoluteString ?? "")")
        print("Method    : \(request.httpMethod ?? "")")
        print("Headers   : \(request.allHTTPHeaderFields ?? [:])")
        if let parameters = endpoint.parameters {
            print("Parameters: \(parameters)")
        }
        print("=================================================\n")
        do {
            let (data, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse else {
                print("❌ Invalid HTTP Response")
                throw NetworkError.invalidResponse
            }
            print("\n================== API RESPONSE ==================")
            print("Status Code: \(http.statusCode)")
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw Response:\n\(responseString)")
            }
            print("==================================================\n")
            switch http.statusCode {

            case 200...299:
                break

            case 400...499:
                throw NetworkError.clientError(http.statusCode)

            case 500...599:
                throw NetworkError.serverError(http.statusCode)

            default:
                throw NetworkError.unknownError(http.statusCode)
            }

            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                print("✅ Successfully decoded \(T.self)\n")
                return decodedResponse

            } catch {
                print("❌ Decoding Failed")
                print(error)
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response causing decode failure:\n\(responseString)")
                }
                throw NetworkError.decodingFailed
            }
        } catch {
            print("❌ Network Error")
            print(error.localizedDescription)

            throw error
        }
    }
}



extension NetworkManager {

    func uploadMultipart<T: Decodable>(
        from endpoint: Endpoint,
        image: UIImage?,
        imageName: String = "user_image"
    ) async throws -> T {

        let boundary = UUID().uuidString

        var request = try endpoint.urlRequest()
        print("request ------>>>1", request)
        request.setValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )

        print("request ------>>>2", request)
        
        var body = Data()

        if let image {

            let imageData = image.jpegData(compressionQuality: 0.3)!

            body.append("--\(boundary)\r\n")
            body.append(
                "Content-Disposition: form-data; name=\"\(imageName)\"; filename=\"profile.jpg\"\r\n"
            )
            body.append("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.append("\r\n")
        }

        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        print("\n=========== MULTIPART REQUEST ===========")
        print(request.url?.absoluteString ?? "")
        print("=========================================\n")

        let (data, response) = try await session.data(for: request)
        
        print("\n=========== response ===========")
        print(data, response)
        

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        print("Status : \(http.statusCode)")

        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }

        switch http.statusCode {

        case 200...299:
            break

        case 400...499:
            throw NetworkError.clientError(http.statusCode)

        case 500...599:
            throw NetworkError.serverError(http.statusCode)

        default:
            throw NetworkError.unknownError(http.statusCode)
        }

        do {

            return try JSONDecoder().decode(T.self, from: data)

        } catch {

            throw NetworkError.decodingFailed
        }
    }
}

protocol NetworkManaging {

    func fetch<T: Decodable>(
        from endpoint: Endpoint
    ) async throws -> T

    func uploadMultipart<T: Decodable>(
        from endpoint: Endpoint,
        image: UIImage?,
        imageName: String
    ) async throws -> T
}


extension Data {

    mutating func append(_ string: String) {

        append(string.data(using: .utf8)!)
    }
}
