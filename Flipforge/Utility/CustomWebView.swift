//
//  CustomWebView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI
import WebKit

struct CustomWebView: UIViewRepresentable {

    let urlString: String

    func makeUIView(
        context: Context
    ) -> WKWebView {

        let webView = WKWebView()

        if let url = URL(
            string: urlString
        ) {

            webView.load(
                URLRequest(url: url)
            )
        }

        return webView
    }

    func updateUIView(
        _ uiView: WKWebView,
        context: Context
    ) {
    }
}
