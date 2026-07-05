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
    @Binding var progress: Double

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {

        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(
            frame: .zero,
            configuration: configuration
        )

        webView.scrollView.contentInset = UIEdgeInsets(
            top: 12,
            left: 8,
            bottom: 20,
            right: 8
        )

        webView.allowsBackForwardNavigationGestures = true

        webView.scrollView.bounces = true
        webView.scrollView.keyboardDismissMode = .interactive

        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false

        webView.scrollView.contentInsetAdjustmentBehavior = .never

        context.coordinator.observeProgress(
            of: webView,
            progress: $progress
        )

        if let url = URL(string: urlString) {

            webView.load(
                URLRequest(url: url)
            )
        }

        return webView
    }

    func updateUIView(
        _ webView: WKWebView,
        context: Context
    ) {

        guard
            let current = webView.url?.absoluteString,
            current != urlString,
            let url = URL(string: urlString)
        else {
            return
        }

        webView.load(
            URLRequest(url: url)
        )
    }
}

extension CustomWebView {

    final class Coordinator: NSObject,
                             WKNavigationDelegate,
                             WKUIDelegate {

        private var observation: NSKeyValueObservation?
        private var progress: Binding<Double>?

        deinit {
            observation?.invalidate()
        }

        func observeProgress(
            of webView: WKWebView,
            progress: Binding<Double>
        ) {

            self.progress = progress

            observation = webView.observe(
                \.estimatedProgress,
                options: [.new]
            ) { [weak self] _, change in

                guard
                    let self,
                    let value = change.newValue
                else {
                    return
                }

                DispatchQueue.main.async {

                    self.progress?.wrappedValue = value

                    if value < 1 {

                     //   LoadingManager.shared.show()

                    } else {

                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 0.25
                        ) {

                           // LoadingManager.shared.hide()

                            withAnimation {

                                self.progress?.wrappedValue = 0
                            }
                        }
                    }
                }
            }
        }

        // MARK: Navigation

        func webView(
            _ webView: WKWebView,
            didStartProvisionalNavigation navigation: WKNavigation!
        ) {

         //   LoadingManager.shared.show()
        }

        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation!
        ) {

            let js = """
            var style = document.createElement('style');
            style.innerHTML = `
            html, body {
                margin: 0 !important;
                padding: 10px !important;
                box-sizing: border-box;
                line-height: 1.6;
            }

            img {
                max-width: 100% !important;
                height: auto !important;
            }

            table {
                width: 100% !important;
            }

            iframe {
                max-width: 100% !important;
            }
            `;
            document.head.appendChild(style);
            """

            webView.evaluateJavaScript(js)
            LoadingManager.shared.hide()
        }

        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation!,
            withError error: Error
        ) {

            LoadingManager.shared.hide()
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation!,
            withError error: Error
        ) {

            LoadingManager.shared.hide()
        }

        // MARK: target="_blank"

        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {

            if navigationAction.targetFrame == nil {

                webView.load(
                    navigationAction.request
                )
            }

            return nil
        }

        // MARK: Decide Policy

        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {

            decisionHandler(.allow)
        }

        // MARK: SSL Challenge

        func webView(
            _ webView: WKWebView,
            didReceive challenge: URLAuthenticationChallenge,
            completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
        ) {

            completionHandler(
                .performDefaultHandling,
                nil
            )
        }
    }
}
