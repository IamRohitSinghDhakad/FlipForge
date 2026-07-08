//
//  SubscriptionWebView.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 08/07/26.
//

import SwiftUI
import WebKit

struct SubscriptionWebView: UIViewRepresentable {

    let urlString: String
    let onPaymentSuccess: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onPaymentSuccess: onPaymentSuccess)
    }

    func makeUIView(context: Context) -> WKWebView {

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(
            frame: .zero,
            configuration: config
        )

        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator

        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false

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
    }
}


extension SubscriptionWebView {

    final class Coordinator: NSObject,
                             WKNavigationDelegate,
                             WKUIDelegate {

        let onPaymentSuccess: () -> Void
        private var urlObservation: NSKeyValueObservation?

        init(onPaymentSuccess: @escaping () -> Void) {
            self.onPaymentSuccess = onPaymentSuccess
        }

        func webView(
            _ webView: WKWebView,
            didStartProvisionalNavigation navigation: WKNavigation!
        ) {

            LoadingManager.shared.show()
        }

        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation!
        ) {

            print("didFinish:", webView.url?.absoluteString ?? "")
            LoadingManager.shared.hide()
        }

        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation!,
            withError error: Error
        ) {
            print("didFail:", webView.url?.absoluteString ?? "")
            LoadingManager.shared.hide()
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation!,
            withError error: Error
        ) {
            print("didFailProvisionalNavigation:", webView.url?.absoluteString ?? "")
            LoadingManager.shared.hide()
        }
        
        func webView(
            _ webView: WKWebView,
            didCommit navigation: WKNavigation!
        ) {
            print("didCommit:", webView.url?.absoluteString ?? "")
        }

        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            print("Content Process Terminated")
        }

        func webView(
            _ webView: WKWebView,
            didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!
        ) {
            print("Server Redirect:", webView.url?.absoluteString ?? "")
        }
        
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationResponse: WKNavigationResponse,
            decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
        ) {

            print("Response:", navigationResponse.response.url?.absoluteString ?? "")

            decisionHandler(.allow)
        }
        
        
        func observeURL(of webView: WKWebView) {

            urlObservation = webView.observe(\.url, options: [.new]) { [weak self] webView, _ in
                print("URL Changed ->", webView.url?.absoluteString)
                guard let url = webView.url?.absoluteString else {
                    return
                }

                print("URL Changed ->", url)

                if url.contains("success") ||
                    url.contains("pay") ||
                    url.contains("checkout") {

                    // inspect here
                }
            }
        }

        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {

            if let url = navigationAction.request.url?.absoluteString {

                print("navigationAction", url)

                if url.contains("/c/pay/") {

                    onPaymentSuccess()
                }
            }

            decisionHandler(.allow)
        }

        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {

            if navigationAction.targetFrame == nil {

                webView.load(navigationAction.request)
            }

            return nil
        }
    }
}


struct SubscriptionCheckoutView: View {

    let url: String

    @EnvironmentObject
    var router: Router

    @StateObject
    private var vm = SubscriptionViewModel()

    var body: some View {

        ZStack {

            Image(.loginBg)
                .resizable()
                .ignoresSafeArea()

            SubscriptionWebView(
                urlString: url
            ) {

            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {

            ToolbarItem(
                placement: .topBarLeading
            ) {

                Button {

                    Task {

                        LoadingManager.shared.show()

                        await vm.checkSubscription()

                        LoadingManager.shared.hide()

                        if vm.isSubscribed {

                            router.popToRoot()

                        } else {

                            router.pop()
                        }
                    }

                } label: {

                    Image(systemName: "chevron.left")
                }            }
        }
    }
}
