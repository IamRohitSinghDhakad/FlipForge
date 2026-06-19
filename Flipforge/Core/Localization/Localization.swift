//
//  Localization.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//


import Foundation
import SwiftUI
import Combine

extension String {
    /// Returns the localized string for this key using Localizable.strings.
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    /// Returns a formatted localized string.
    func localized(_ args: CVarArg...) -> String {
        return String(format: self.localized, arguments: args)
    }
}


final class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    @AppStorage("selectedLanguage") private var storedLang = "en"
    @Published var languageCode: String = Locale.current.languageCode ?? "en" {
        didSet {
            storedLang = languageCode
            // Optionally update AppleLanguages for system dialogs
            UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        }
    }
    private init() {
        languageCode = storedLang
    }
}
