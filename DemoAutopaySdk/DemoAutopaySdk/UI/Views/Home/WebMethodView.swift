//
//  WebMethodView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

struct WebMethodView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var colorManager: ColorManager
    @ObservedObject var viewModel: WebMethodViewModel

    var body: some View {
        content
            .task {
                await viewModel.performWebViewMethod()
            }
            .onReceive(viewModel.$shouldShowWebView) {
                if !$0 {
                    dismiss()
                }
            }
            .navigationTitle("demo_home_form_webview")
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            LoaderView(
                size: .large,
                trackColor: Color.clear,
                spinnerColor: colorManager.brandColor
            )
        case .error(let errorState):
            ErrorView(state: errorState)
        case .content:
            RedirectWebView(url: viewModel.webViewUrl) { result, error in
                viewModel.cardPaymentDidEnd(result: result, error: error)
            }
        }
    }
}
