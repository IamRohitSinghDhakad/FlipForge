//
//  AuthRepositry.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

import Foundation
import UIKit

protocol AuthRepositoryProtocol {

    func login(
        email: String,
        password: String
    ) async throws -> LoginModel

    func signup(
        name: String,
        email: String,
        password: String,
        image: UIImage?
    ) async throws -> SignupResponse
    
    func getProfile(
        userId: String
    ) async throws -> ProfileResponse

    func getProperties(
        userId: String
    ) async throws -> PropertyListResponse
    
    func propertyAnalysis(
        request: PropertyAnalysisRequest
    ) async throws -> PropertyAnalysisResponse
    
    func exportPDF(
           request: PropertyAnalysisRequest
       ) async throws -> URL
    
    func getMasterSettings(
        userId: String
    ) async throws -> MasterSettingsResponse
    
    func saveMasterSettings(
        request: MasterSettingsRequest
    ) async throws -> BaseResponse
    
    func deleteProperty(
        request: DeletePropertyRequest
    ) async throws -> BaseResponse
    
    func forgotPassword(
        email: String
    ) async throws -> BaseResponse
    
    func activeSubscription(
        userId: String
    ) async throws -> SubscriptionStatusResponse
}


final class AuthRepository: AuthRepositoryProtocol {
    
    private let network: NetworkManaging
    
    init(network: NetworkManaging = NetworkManager.shared) {
        self.network = network
    }
    
    func login(
        email: String,
        password: String
    ) async throws -> LoginModel {
        
        let endpoint = APIEndpoint.login(
            email: email,
            password: password,
            deviceType: "iOS"
        )
        
        return try await network.fetch(from: endpoint)
    }
    
    
    func signup(
        name: String,
        email: String,
        password: String,
        image: UIImage?
    ) async throws -> SignupResponse {

        let endpoint = APIEndpoint.signup(
            name: name,
            email: email,
            password: password,
            deviceType: "iOS"
        )

        return try await network.uploadMultipart(
            from: endpoint,
            image: image,
            imageName: "user_image"
        )
    }
    
    
    func getProfile(userId: String) async throws -> ProfileResponse {

        let endpoint = APIEndpoint.getProfile(
            userId: userId
        )

        return try await network.fetch(from: endpoint)
    }
    
    
    func getProperties(userId: String) async throws -> PropertyListResponse {

        let endpoint = APIEndpoint.getProperties(
            userId: userId
        )

        return try await network.fetch(from: endpoint)
    }
    
    func propertyAnalysis(
        request: PropertyAnalysisRequest
    ) async throws -> PropertyAnalysisResponse {

        let endpoint = APIEndpoint.propertyAnalysis(
            request: request
        )

        return try await network.fetch(from: endpoint)
    }
    
    func exportPDF(request: PropertyAnalysisRequest) async throws -> URL {

        var components = URLComponents(
            string: "\(APIConstants.baseURL)/property_analysis"
        )!

        components.queryItems = request.dictionary.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }

        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "POST"

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let http = response as? HTTPURLResponse,
              http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let fileURL = FileManager.default.temporaryDirectory
            .appendingPathComponent("FlipAnalyzer.pdf")

        try data.write(to: fileURL)

        return fileURL
    }
    
    
    func getMasterSettings(
        userId: String
    ) async throws -> MasterSettingsResponse {

        let endpoint = APIEndpoint.getMasterSettings(
            userId: userId
        )

        return try await network.fetch(from: endpoint)
    }
    
    func saveMasterSettings(
        request: MasterSettingsRequest
    ) async throws -> BaseResponse {

        let endpoint = APIEndpoint.saveMasterSettings(
            request: request
        )

        return try await network.fetch(from: endpoint)
    }
    
    func deleteProperty(
        request: DeletePropertyRequest
    ) async throws -> BaseResponse {

        let endpoint = APIEndpoint.deleteProperty(propertyId: request.propertyId)

        return try await network.fetch(from: endpoint)
    }
    
    func forgotPassword(
        email: String
    ) async throws -> BaseResponse {

        let endpoint = APIEndpoint.forgotPassword(
            email: email
        )

        return try await network.fetch(from: endpoint)
    }
    
    func activeSubscription(
        userId: String
    ) async throws -> SubscriptionStatusResponse {

        let endpoint = APIEndpoint.activeSubscription(
            userId: userId
        )

        return try await network.fetch(
            from: endpoint
        )
    }
    
    
}
