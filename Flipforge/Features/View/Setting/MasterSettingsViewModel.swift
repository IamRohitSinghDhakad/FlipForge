//
//  MasterSettingsViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//
import SwiftUI
import Combine


final class MasterSettingsViewModel: BaseViewModel {
    
    @Published var settings = AnalysisSettings()
    
    
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }
    

    func save() async {
        guard validate() else {
            return
        }
        
        LoadingManager.shared.show()
        defer { LoadingManager.shared.hide() }

        do {
            _ = try await repository.saveMasterSettings(
                request: makeRequest()
            )
            try await loadSettings()
            showSuccess(title: "Success", message: "Settings updated successfully")
        } catch {
            showApiError(error)
        }
    }
    
    func loadSettings() async throws {
        
        LoadingManager.shared.show()
        defer { LoadingManager.shared.hide() }

        let response = try await repository.getMasterSettings(
            userId: UserDefaultsManager.shared.userId
        )

        settings = response.result
    }
}

extension MasterSettingsViewModel{
    
    private func makeRequest() -> MasterSettingsRequest {

        MasterSettingsRequest(

            userId: UserDefaultsManager.shared.userId,

            hardMoneyRate: settings.hardMoneyRate,
            hardMoneyPoints: settings.hardMoneyPoints,
            hardMoneyFees: settings.hardMoneyFees,
            hardMoneyFinance: settings.hardMoneyFinance,

            privateCapitalRate: settings.privateCapitalRate,
            privateCapitalPoints: settings.privateCapitalPoints,
            privateCapitalFees: settings.privateCapitalFees,
            privateCapitalFinance: settings.privateCapitalFinance,

            titlePurchase: settings.titleCostsPurchasePercent,
            titleSale: settings.titleCostsSalePercent,
            
            utilities: settings.utilitiesPerMonth,
            insurance: settings.insurancePerMonth,
            
            propertyTax: settings.propertyTaxRate,
            realtorFees: settings.realtorFeesPercent
        )
    }
    
    func validate() -> Bool {

        if settings.hardMoneyRate.isEmpty {
            showAlert("Please enter Hard Money Rate")
            return false
        }

        if settings.hardMoneyPoints.isEmpty {
            showAlert("Please enter Hard Money Points")
            return false
        }

        if settings.hardMoneyFees.isEmpty {
            showAlert("Please enter Hard Money Fees")
            return false
        }

        if settings.hardMoneyFinance.isEmpty {
            showAlert("Please enter Hard Money Finance")
            return false
        }

        if settings.privateCapitalRate.isEmpty {
            showAlert("Please enter Private Capital Rate")
            return false
        }

        if settings.privateCapitalPoints.isEmpty {
            showAlert("Please enter Private Capital Points")
            return false
        }

        if settings.privateCapitalFees.isEmpty {
            showAlert("Please enter Private Capital Fees")
            return false
        }

        if settings.privateCapitalFinance.isEmpty {
            showAlert("Please enter Private Capital Finance")
            return false
        }

        if settings.titleCostsPurchasePercent.isEmpty {
            showAlert("Please enter Purchase Title Cost")
            return false
        }

        if settings.titleCostsSalePercent.isEmpty {
            showAlert("Please enter Sale Title Cost")
            return false
        }

        if settings.utilitiesPerMonth.isEmpty {
            showAlert("Please enter Utilities Per Month")
            return false
        }

        if settings.insurancePerMonth.isEmpty {
            showAlert("Please enter Insurance Per Month")
            return false
        }

        if settings.propertyTaxRate.isEmpty {
            showAlert("Please enter Property Tax Rate")
            return false
        }

        if settings.realtorFeesPercent.isEmpty {
            showAlert("Please enter Realtor Fees")
            return false
        }

        return true
    }
}
