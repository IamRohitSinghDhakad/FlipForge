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

    @Published var buyingExpanded = true
    @Published var holdingExpanded = true
    @Published var sellingExpanded = true

    let result: PropertyResultModel

    init(
        result: PropertyResultModel
    ) {

        self.result = result
    }
}
