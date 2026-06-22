//
//  HomeViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: BaseViewModel {

    @Published var userName = "Rohit"

    @Published var properties: [PropertyModel] = [

        PropertyModel(
            title: "VIP Villa, Sector 26",
            sqft: 1000,
            purchasePrice: 65000,
            imageName: "property"
        ),

        PropertyModel(
            title: "123 Road AB Bhopal",
            sqft: 1000,
            purchasePrice: 5000,
            imageName: "property"
        ),

        PropertyModel(
            title: "209 Sai Ram",
            sqft: 1000,
            purchasePrice: 3000,
            imageName: "property"
        )
    ]
}
