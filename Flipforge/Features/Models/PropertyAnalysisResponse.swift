//
//  PropertyAnalysisResponse.swift
//  Flipforge
//

import Foundation

struct PropertyAnalysisResponse: Codable {

    let result: PropertyAnalysisResult
    let message: String
    let status: Int
}

struct PropertyAnalysisResult: Codable, Hashable {

    @FlexibleString var propertyId: String

    let settings: AnalysisSettings?
    let propertyInfo: PropertyInfo?
    let scenarios: PropertyScenarios?

    enum CodingKeys: String, CodingKey {
        case propertyId = "property_id"
        case settings
        case propertyInfo = "property_info"
        case scenarios
    }
}

struct AnalysisSettings: Codable, Hashable  {

    @FlexibleString var id: String
    @FlexibleString var userId: String

    @FlexibleString var hardMoneyRate: String
    @FlexibleString var hardMoneyPoints: String
    @FlexibleString var hardMoneyFees: String
    @FlexibleString var hardMoneyFinance: String

    @FlexibleString var privateCapitalRate: String
    @FlexibleString var privateCapitalPoints: String
    @FlexibleString var privateCapitalFees: String
    @FlexibleString var privateCapitalFinance: String

    @FlexibleString var titleCostsPurchasePercent: String
    @FlexibleString var titleCostsSalePercent: String

    @FlexibleString var utilitiesPerMonth: String
    @FlexibleString var insurancePerMonth: String
    @FlexibleString var propertyTaxRate: String
    @FlexibleString var realtorFeesPercent: String

    @FlexibleString var updatedAt: String

    enum CodingKeys: String, CodingKey {

        case id
        case userId = "user_id"

        case hardMoneyRate = "hard_money_rate"
        case hardMoneyPoints = "hard_money_points"
        case hardMoneyFees = "hard_money_fees"
        case hardMoneyFinance = "hard_money_finance"

        case privateCapitalRate = "private_capital_rate"
        case privateCapitalPoints = "private_capital_points"
        case privateCapitalFees = "private_capital_fees"
        case privateCapitalFinance = "private_capital_finance"

        case titleCostsPurchasePercent = "title_costs_purchase_percent"
        case titleCostsSalePercent = "title_costs_sale_percent"

        case utilitiesPerMonth = "utilities_per_month"
        case insurancePerMonth = "insurance_per_month"

        case propertyTaxRate = "property_tax_rate"
        case realtorFeesPercent = "realtor_fees_percent"

        case updatedAt = "updated_at"
    }
}

struct PropertyInfo: Codable, Hashable  {

    @FlexibleString var propertyAddress: String
    @FlexibleString var totalSqFeet: String
    @FlexibleString var bedBath: String
    @FlexibleString var numUnits: String
    @FlexibleString var dateOfEstimate: String

    @FlexibleString var arv: String
    @FlexibleString var estimatedRepairCosts: String
    @FlexibleString var purchasePrice: String
    @FlexibleString var holdingTimeMonths: String

    @FlexibleString var inspections: String
    @FlexibleString var cfkMiscCosts: String
    @FlexibleString var hoaCondoFees: String
    @FlexibleString var miscHoldingCosts: String
    @FlexibleString var stagingCostsPct: String
    @FlexibleString var photosInspectionsPct: String

    enum CodingKeys: String, CodingKey {

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
    }
}

struct PropertyScenarios: Codable, Hashable  {

    let hardMoney: AnalysisScenario?
    let privateCapital: AnalysisScenario?
    let cash: AnalysisScenario?

    enum CodingKeys: String, CodingKey {

        case hardMoney = "hard_money"
        case privateCapital = "private_capital"
        case cash
    }
}

struct AnalysisScenario: Codable, Hashable  {

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

    /// Reuse existing model from PropertyModel.swift
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
