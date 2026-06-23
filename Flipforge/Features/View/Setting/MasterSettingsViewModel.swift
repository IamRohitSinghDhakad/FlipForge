//
//  MasterSettingsViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//
import SwiftUI
import Combine


final class MasterSettingsViewModel: ObservableObject {

    @Published var settings =
    MasterSettingsModel()

    func save() {

        print("Save Settings")

        // API Call
    }
}
