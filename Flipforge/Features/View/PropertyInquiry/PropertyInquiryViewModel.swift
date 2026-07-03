//
//  PropertyInquiryViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import Foundation
import Combine

@MainActor
final class PropertyInquiryViewModel: BaseViewModel {

    @Published var inquiry = PropertyInquiryModel()
    
    private let repository: AuthRepositoryProtocol

    private let mode: InquiryMode
    private var propertyId = ""
    
    // MARK: Property

    @Published var propertyAddress = ""
    @Published var totalSqFeet = ""
    @Published var bedBath = ""
    @Published var numberOfUnits = ""
    @Published var dateOfEstimate = ""

    // MARK: Financial

    @Published var arv = ""
    @Published var repairCosts = ""
    @Published var purchasePrice = ""
    @Published var holdingMonths = ""

    // MARK: Buying

    @Published var inspectionCost = ""
    @Published var miscCost = ""

    // MARK: Holding

    @Published var hoaFees = ""
    @Published var monthlyMiscCost = ""

    // MARK: Selling

    @Published var stagingCost = ""
    @Published var photosInspectionCost = ""
    
    init(
        mode: InquiryMode,
        repository: AuthRepositoryProtocol = AuthRepository()
    ) {

        self.mode = mode
        self.repository = repository

        super.init()

        if case let .edit(property) = mode {

            propertyId = property.propertyId
            configure(with: property)
        }
    }

    func configure(with property: PropertyModel) {

        propertyAddress = property.propertyAddress
        totalSqFeet = property.totalSqFeet
        bedBath = property.bedBath
        numberOfUnits = property.numUnits
        dateOfEstimate = property.dateOfEstimate

        arv = property.arv
        repairCosts = property.estimatedRepairCosts
        purchasePrice = property.purchasePrice
        holdingMonths = property.holdingTimeMonths

        inspectionCost = property.inspections
        miscCost = property.cfkMiscCosts

        hoaFees = property.hoaCondoFees
        monthlyMiscCost = property.miscHoldingCosts

        stagingCost = property.stagingCostsPct
        photosInspectionCost = property.photosInspectionsPct
    }
    
    //MARK: Build Request
    private func makeRequest(action: String) -> PropertyAnalysisRequest {

        PropertyAnalysisRequest(

            userId: UserDefaultsManager.shared.userId,

            propertyId:
                action == "save"
                ? propertyId
                : "",

            propertyAddress: propertyAddress,
            totalSqFeet: totalSqFeet,
            bedBath: bedBath,
            numUnits: numberOfUnits,
            dateOfEstimate: dateOfEstimate,

            arv: arv,
            estimatedRepairCosts: repairCosts,
            purchasePrice: purchasePrice,
            holdingTimeMonths: holdingMonths,

            inspections: inspectionCost,
            cfkMiscCosts: miscCost,

            hoaCondoFees: hoaFees,
            miscHoldingCosts: monthlyMiscCost,

            stagingCostsPct: stagingCost,
            photosInspectionsPct: photosInspectionCost,

            action: action
        )
    }
    
    
    
    func saveRequest() -> PropertyAnalysisRequest {
        makeRequest(action: "save")
    }

    func analysisRequest() -> PropertyAnalysisRequest {
        makeRequest(action: "analysis")
    }


    
    //==================== XXXXX   ===============//
    
    private func request(
        action: String,
        includePropertyId: Bool
    ) -> PropertyAnalysisRequest {

        PropertyAnalysisRequest(

            userId: UserSession.userId ?? "",

            propertyId: includePropertyId
                ? propertyId
                : "",

            propertyAddress: propertyAddress,
            totalSqFeet: totalSqFeet,
            bedBath: bedBath,
            numUnits: numberOfUnits,
            dateOfEstimate: dateOfEstimate,

            arv: arv,
            estimatedRepairCosts: repairCosts,
            purchasePrice: purchasePrice,
            holdingTimeMonths: holdingMonths,

            inspections: inspectionCost,
            cfkMiscCosts: miscCost,
            hoaCondoFees: hoaFees,
            miscHoldingCosts: monthlyMiscCost,
            stagingCostsPct: stagingCost,
            photosInspectionsPct: photosInspectionCost,

            action: action
        )
    }
    
    func save() async throws -> PropertyAnalysisResponse {

        let request = request(
            action: "save",
            includePropertyId: true
        )

        return try await repository.propertyAnalysis(
            request: request
        )
    }
    
    func analyse() async throws -> PropertyAnalysisResponse {

        let request = request(
            action: "analysis",
            includePropertyId: false
        )

        return try await repository.propertyAnalysis(
            request: request
        )
    }
    
}
