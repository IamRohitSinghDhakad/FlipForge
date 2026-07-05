//
//  PropertyResultViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI
import Combine

final class PropertyResultViewModel: ObservableObject {

    @Published var selectedType: FinancingType = .hardMoney

    @Published var buyingExpanded = false
    @Published var holdingExpanded = false
    @Published var sellingExpanded = false
    
    @Published var pdfURL: URL?
    @Published var isDownloadingPDF = false

    let result: PropertyAnalysisResult
    
    private let repository: AuthRepositoryProtocol

    init(result: PropertyAnalysisResult,repository: AuthRepositoryProtocol = AuthRepository()) {
        self.result = result
        self.repository = repository
    }

    var scenario: AnalysisScenario? {

        switch selectedType {

        case .hardMoney:
            return result.scenarios?.hardMoney

        case .privateCapital:
            return result.scenarios?.privateCapital

        case .cash:
            return result.scenarios?.cash
        }
    }
}

extension PropertyResultViewModel {

    var buyingCosts: [CostItem] {

        guard let b = scenario?.breakdown else { return [] }

        return [
            CostItem(title: "Cash to Purchase", amount: scenario?.cashToPurchase ?? ""),
            CostItem(title: "Title Costs (Purchase)", amount: b.titleCostsPurchase),
            CostItem(title: "Lender Fees", amount: b.lenderFees),
            CostItem(title: "Points", amount: b.points),
            CostItem(title: "Inspections", amount: b.inspections),
            CostItem(title: "CFK / Misc", amount: b.cfkMisc)
        ]
    }

    var holdingCosts: [CostItem] {

        guard let b = scenario?.breakdown else { return [] }

        return [
            CostItem(title: "Utilities/Maintainance", amount: b.utilities),
            CostItem(title: "Insurance", amount: b.insurance),
            CostItem(title: "Property Taxes", amount: b.propertyTaxes),
            CostItem(title: "Loan Interest", amount: b.loanInterest),
            CostItem(title: "HOA/Condo", amount: b.hoaTotal),
            CostItem(title: "Misc Holding", amount: b.miscTotal)
        ]
    }

    var sellingCosts: [CostItem] {

        guard let b = scenario?.breakdown else { return [] }

        return [
            CostItem(title: "Title Costs (Sale)", amount: b.titleCostsSale),
            CostItem(title: "Realtor Fees", amount: b.realtorFees),
            CostItem(title: "Staging Costs", amount: b.stagingCosts),
            CostItem(title: "Photos / Inspections", amount: b.photosCosts)
        ]
    }
}

extension PropertyResultViewModel{
    
    func exportPDF() async {

        isDownloadingPDF = true

        defer {
            isDownloadingPDF = false
        }
        
        

        do {

            let request = makePDFRequest()

            pdfURL = try await repository.exportPDF(
                request: request
            )

        } catch {

            print(error.localizedDescription)
        }
    }
    
    private func makePDFRequest() -> PropertyAnalysisRequest {

        let info = result.propertyInfo

        return PropertyAnalysisRequest(

            userId: UserSession.userId ?? "",

            propertyId: result.propertyId,

            propertyAddress: info?.propertyAddress ?? "",
            totalSqFeet: info?.totalSqFeet ?? "",
            bedBath: info?.bedBath ?? "",
            numUnits: info?.numUnits ?? "",
            dateOfEstimate: info?.dateOfEstimate ?? "",

            arv: info?.arv ?? "",
            estimatedRepairCosts: info?.estimatedRepairCosts ?? "",
            purchasePrice: info?.purchasePrice ?? "",
            holdingTimeMonths: info?.holdingTimeMonths ?? "",

            inspections: info?.inspections ?? "",
            cfkMiscCosts: info?.cfkMiscCosts ?? "",
            hoaCondoFees: info?.hoaCondoFees ?? "",
            miscHoldingCosts: info?.miscHoldingCosts ?? "",

            stagingCostsPct: info?.stagingCostsPct ?? "",
            photosInspectionsPct: info?.photosInspectionsPct ?? "",

            action: "pdf"
        )
    }
    
}


extension String {

    var doubleValue: Double {
        Double(replacingOccurrences(of: "%", with: "")) ?? 0
    }
}
