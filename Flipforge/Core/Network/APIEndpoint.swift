//
//  APIEndpoint.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//


import Foundation

enum APIConstants {

    /// Change this to your production URL
    static let baseURL = "https://ambitious.in.net/Arun/flipforge/api/"
}


enum APIEndpoint: Endpoint {

    case login(
        email: String,
        password: String,
        deviceType: String
    )

    case forgotPassword(
        email: String
    )

    case signup(
        name: String,
        email: String,
        password: String,
        deviceType: String,
        imageData: Data?
    )

    case saveMasterSettings(
        request: MasterSettingsRequest
    )

    case getMasterSettings(
        userId: String
    )

    case propertyAnalysis(
        request: PropertyAnalysisRequest
    )

    case getProperties(
        userId: String
    )

    case deleteProperty(
        propertyId: String
    )

    case deleteAccount(
        userId: String
    )

    case paymentStatus

    case activeSubscription(
        userId: String
    )

    case getProfile(
        userId: String
    )

    case updateProfile(
        request: UpdateProfileRequest
    )

    case downloadPDF(
        url: URL
    )

}


extension APIEndpoint {

    var baseURL: URL {
        URL(string: APIConstants.baseURL)!
    }
}



extension APIEndpoint {

    var path: String {

        switch self {

        case .login:
            return "login"

        case .forgotPassword:
            return "forgot_password"

        case .signup:
            return "signup"

        case .saveMasterSettings:
            return "save_master_settings"

        case .getMasterSettings:
            return "get_master_settings"

        case .propertyAnalysis:
            return "property_analysis"

        case .getProperties:
            return "get_properties"

        case .deleteProperty:
            return "delete_property"

        case .deleteAccount:
            return "delete_account"

        case .paymentStatus:
            return "payment_status"

        case .activeSubscription:
            return "activeSubscription"

        case .getProfile:
            return "get_profile"

        case .updateProfile:
            return "update_profile"

        case .downloadPDF:
            return ""
        }
    }
}


extension APIEndpoint {

    var method: HTTPMethod {

        switch self {

        case .downloadPDF:
            return .get

        default:
            return .post
        }
    }
}

extension APIEndpoint {

    var headers: [String : String]? {

        switch self {

        case .signup,
             .updateProfile:

            return nil

        default:

            return [

                "Content-Type": "application/json"

            ]
        }
    }
}

extension APIEndpoint {

    var parameters: [String : Any]? {

        switch self {

        case let .login(email, password, deviceType):

            return [

                "email": email,
                "password": password,
                "device_type": deviceType

            ]

        case let .forgotPassword(email):

            return [

                "email": email

            ]

        case let .saveMasterSettings(request):

            return request.dictionary

        case let .getMasterSettings(userId):

            return [

                "user_id": userId

            ]

        case let .propertyAnalysis(request):

            return request.dictionary

        case let .getProperties(userId):

            return [

                "user_id": userId

            ]

        case let .deleteProperty(propertyId):

            return [

                "property_id": propertyId

            ]

        case let .deleteAccount(userId):

            return [

                "user_id": userId

            ]

        case let .activeSubscription(userId):

            return [

                "user_id": userId

            ]

        case let .getProfile(userId):

            return [

                "login_user_id": userId

            ]

        case let .updateProfile(request):

            return [
                    "user_id": request.userId,
                    "name": request.name,
                    "email": request.email,
                    "mobile": request.mobile,
                    "service_rate": request.serviceRate,
                    "country": request.country,
                    "state": request.state,
                    "city": request.city,
                    "zip_code": request.zipCode,
                    "address": request.address,
                    "lang": request.language
                ]

        default:

            return nil
        }
    }
}


extension Encodable {

    var dictionary: [String: Any] {

        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            return [:]
        }

        return json
    }
}

