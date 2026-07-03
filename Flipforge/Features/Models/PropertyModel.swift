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

struct PropertyListResponse: Codable {
    let result: [PropertyModel]
    let message: String
    let status: Int
}

struct PropertyModel: Identifiable, Codable, Hashable {

    var id: String { propertyId }

    let propertyId: String
    let userId: String
    let propertyAddress: String

    let totalSqFeet: String
    let bedBath: String
    let numUnits: String
    let dateOfEstimate: String

    let arv: String
    let estimatedRepairCosts: String
    let purchasePrice: String
    let holdingTimeMonths: String

    let inspections: String
    let cfkMiscCosts: String
    let hoaCondoFees: String
    let miscHoldingCosts: String
    let stagingCostsPct: String
    let photosInspectionsPct: String

    let scenarioHardMoney: PropertyScenario?
    let scenarioPrivateCapital: PropertyScenario?
    let scenarioCash: PropertyScenario?

    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {

        case propertyId = "property_id"
        case userId = "user_id"
        case propertyAddress = "property_address"
        case totalSqFeet = "total_sq_feet"
        case bedBath = "bed_bath"
        case numUnits = "num_units"
        case dateOfEstimate = "date_of_estimate"
        case arv
        case estimatedRepairCosts = "estimated_repair_costs"
        case purchasePrice = "purchase_price"
        case holdingTimeMonths = "holding_time_months"
        case inspections
        case cfkMiscCosts = "cfk_misc_costs"
        case hoaCondoFees = "hoa_condo_fees"
        case miscHoldingCosts = "misc_holding_costs"
        case stagingCostsPct = "staging_costs_pct"
        case photosInspectionsPct = "photos_inspections_pct"
        case scenarioHardMoney = "scenario_hard_money"
        case scenarioPrivateCapital = "scenario_private_capital"
        case scenarioCash = "scenario_cash"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct PropertyScenario: Codable, Hashable {

    @FlexibleString var loanAmount: String
    @FlexibleString var cashToPurchase: String
    @FlexibleString var totalBuyingCosts: String
    @FlexibleString var totalHoldingCosts: String
    @FlexibleString var totalSellingCosts: String
    @FlexibleString var totalCosts: String
    @FlexibleString var totalCashRequired: String
    @FlexibleString var estimatedNetProfit: String
    @FlexibleString var netReturn: String
    @FlexibleString var netReturnPct: String
    @FlexibleString var cashNetReturn: String
    @FlexibleString var apy: String
    @FlexibleString var arv: String
    @FlexibleString var repairCosts: String


    let breakdown: ScenarioBreakdown?

    enum CodingKeys: String, CodingKey {
        case loanAmount = "loan_amount"
        case cashToPurchase = "cash_to_purchase"
        case totalBuyingCosts = "total_buying_costs"
        case totalHoldingCosts = "total_holding_costs"
        case totalSellingCosts = "total_selling_costs"
        case totalCosts = "total_costs"
        case totalCashRequired = "total_cash_required"
        case estimatedNetProfit = "estimated_net_profit"
        case netReturn = "net_return"
        case netReturnPct = "net_return_pct"
        case cashNetReturn = "cash_net_return"
        case apy
        case arv
        case repairCosts = "repair_costs"
        case breakdown
    }
}

struct ScenarioBreakdown: Codable, Hashable {

    @FlexibleString var titleCostsPurchase: String
    @FlexibleString var lenderFees: String
    @FlexibleString var points: String
    @FlexibleString var inspections: String
    @FlexibleString var cfkMisc: String
    @FlexibleString var utilities: String
    @FlexibleString var insurance: String
    @FlexibleString var propertyTaxes: String
    @FlexibleString var loanInterest: String
    @FlexibleString var hoaTotal: String
    @FlexibleString var miscTotal: String
    @FlexibleString var titleCostsSale: String
    @FlexibleString var realtorFees: String
    @FlexibleString var stagingCosts: String
    @FlexibleString var photosCosts: String


    enum CodingKeys: String, CodingKey {
        case titleCostsPurchase = "title_costs_purchase"
        case lenderFees = "lender_fees"
        case points
        case inspections
        case cfkMisc = "cfk_misc"
        case utilities
        case insurance
        case propertyTaxes = "property_taxes"
        case loanInterest = "loan_interest"
        case hoaTotal = "hoa_total"
        case miscTotal = "misc_total"
        case titleCostsSale = "title_costs_sale"
        case realtorFees = "realtor_fees"
        case stagingCosts = "staging_costs"
        case photosCosts = "photos_costs"
    }
}
