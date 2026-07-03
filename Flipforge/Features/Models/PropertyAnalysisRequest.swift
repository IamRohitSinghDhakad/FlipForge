//
//  PropertyAnalysisRequest.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

struct PropertyAnalysisRequest {

    let userId: String
    let propertyId: String
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
    let action: String
}

extension PropertyAnalysisRequest {

    var dictionary: [String: Any] {

        [

            "user_id": userId,
            "property_id": propertyId,
            "property_address": propertyAddress,
            "total_sq_feet": totalSqFeet,
            "bed_bath": bedBath,
            "num_units": numUnits,
            "date_of_estimate": dateOfEstimate,
            "arv": arv,
            "estimated_repair_costs": estimatedRepairCosts,
            "purchase_price": purchasePrice,
            "holding_time_months": holdingTimeMonths,
            "inspections": inspections,
            "cfk_misc_costs": cfkMiscCosts,
            "hoa_condo_fees": hoaCondoFees,
            "misc_holding_costs": miscHoldingCosts,
            "staging_costs_pct": stagingCostsPct,
            "photos_inspections_pct": photosInspectionsPct,
            "action": action

        ]
    }
}


struct UpdateProfileRequest: Codable {

    let userId: String
    let name: String
    let email: String
    let mobile: String
    let serviceRate: String
    let country: String
    let state: String
    let city: String
    let zipCode: String
    let address: String
    let language: String
}
