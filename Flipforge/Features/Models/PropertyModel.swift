//
//  PropertyModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import Foundation


enum InquiryMode: Hashable {
    case create
    case edit(PropertyModel)
}

struct PropertyModel: Identifiable, Codable, Hashable {

    let id = UUID()

    let title: String
    let sqft: Double
    let purchasePrice: Double
    let imageName: String
}
