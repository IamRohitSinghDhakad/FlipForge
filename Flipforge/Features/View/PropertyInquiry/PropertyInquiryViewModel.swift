//
//  PropertyInquiryViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import Foundation
import Combine

@MainActor
final class PropertyInquiryViewModel:
BaseViewModel {

    @Published var inquiry =
    PropertyInquiryModel()
    
    @Published var propertyAddress = ""
    @Published var totalSqFeet = ""
    @Published var bedBath = ""
    @Published var numberOfUnits = ""
    @Published var estimateDate = Date()

    @Published var arv = ""
    @Published var repairCosts = ""
    @Published var purchasePrice = ""
    @Published var holdingMonths = ""

    @Published var inspectionCost = ""
    @Published var miscCost = ""

    @Published var hoaFees = ""
    @Published var monthlyMiscCost = ""

    @Published var stagingCost = ""
    @Published var photosInspectionCost = ""

    func save() {

        showSuccess(
            title: "Success",
            message: "Property saved successfully"
        )
    }

    func calculate() {

        print("Calculate ROI")
    }
}
