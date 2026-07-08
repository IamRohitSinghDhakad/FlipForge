//
//  SubscriptionStatusResponse.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 08/07/26.
//

import Foundation

struct SubscriptionStatusResponse: Codable {
    let result: SubscriptionStatusResult?
    @FlexibleString var message: String
    @FlexibleString var status: String
}

struct SubscriptionStatusResult: Codable {
    @FlexibleString var status: String
    @FlexibleString var message: String
    @FlexibleString var customer_id: String
    @FlexibleString var subscription_id: String
    @FlexibleString var subscription_status: String
}
