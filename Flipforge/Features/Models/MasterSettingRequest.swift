//
//  MasterSettingRequest.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//


struct MasterSettingsRequest {

    let userId: String

    let hardMoneyRate: String
    let hardMoneyPoints: String
    let hardMoneyFees: String
    let hardMoneyFinance: String

    let privateCapitalRate: String
    let privateCapitalPoints: String
    let privateCapitalFees: String
    let privateCapitalFinance: String

    let titlePurchase: String
    let titleSale: String

    let utilities: String
    let insurance: String
    let propertyTax: String
    let realtorFees: String
}

extension MasterSettingsRequest {

    var dictionary: [String: Any] {

        [

            "user_id": userId,

            "hard_money_rate": hardMoneyRate,
            "hard_money_points": hardMoneyPoints,
            "hard_money_fees": hardMoneyFees,
            "hard_money_finance": hardMoneyFinance,

            "private_capital_rate": privateCapitalRate,
            "private_capital_points": privateCapitalPoints,
            "private_capital_fees": privateCapitalFees,
            "private_capital_finance": privateCapitalFinance,

            "title_costs_purchase_percent": titlePurchase,
            "title_costs_sale_percent": titleSale,

            "utilities_per_month": utilities,
            "insurance_per_month": insurance,
            "property_tax_rate": propertyTax,
            "realtor_fees_percent": realtorFees

        ]
    }
}
