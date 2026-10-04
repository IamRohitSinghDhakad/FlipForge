//
//  PaymentStatusResponse.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 13/07/26.
//

import Foundation

struct PaymentStatusResponse: Codable {
    let result: EmptyResult?
    let message: PaymentStatusMessage
    let status: Int
}

struct EmptyResult: Codable { }

struct PaymentStatusMessage: Codable {
    let payment_status: Int
}
