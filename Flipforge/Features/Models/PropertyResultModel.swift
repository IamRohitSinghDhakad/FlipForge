//
//  PropertyResultModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI
import Foundation


enum FinancingType: String, CaseIterable {

    case hardMoney = "Hard Money"
    case privateCapital = "Private Capital"
    case cash = "Cash"
}

//struct PropertyResultModel: Hashable {
//
//    let estimatedProfit: Double
//
//    let netReturn: Double
//
//    let cashNetReturn: Double
//
//    let annualAPY: Double
//
//    let arv: Double
//
//    let loanAmount: Double
//
//    let cashRequired: Double
//
//    let buyingCosts: [CostItem]
//
//    let holdingCosts: [CostItem]
//
//    let sellingCosts: [CostItem]
//}
//
//struct CostItem: Hashable {
//
//    let title: String
//
//    let amount: Double
//}
//
//
//extension PropertyResultModel {
//
//    static let mock =
//    PropertyResultModel(
//
//        estimatedProfit: 6853,
//
//        netReturn: 22.8,
//
//        cashNetReturn: 22.8,
//
//        annualAPY: 45.7,
//
//        arv: 100000,
//
//        loanAmount: 58500,
//
//        cashRequired: 29997,
//
//        buyingCosts: [
//            CostItem(
//                title: "Cash To Purchase",
//                amount: 6500
//            ),
//            CostItem(
//                title: "Title Costs Purchase",
//                amount: 650
//            ),
//            CostItem(
//                title: "Lender Fees",
//                amount: 1000
//            ),
//            CostItem(
//                title: "Points",
//                amount: 585
//            )
//        ],
//
//        holdingCosts: [
//            CostItem(
//                title: "Utilities",
//                amount: 2400
//            ),
//            CostItem(
//                title: "Insurance",
//                amount: 1200
//            ),
//            CostItem(
//                title: "Property Taxes",
//                amount: 406
//            )
//        ],
//
//        sellingCosts: [
//            CostItem(
//                title: "Title Costs Sale",
//                amount: 1150
//            ),
//            CostItem(
//                title: "Realtor Fees",
//                amount: 3500
//            ),
//            CostItem(
//                title: "Photos",
//                amount: 200
//            )
//        ]
//    )
//}
