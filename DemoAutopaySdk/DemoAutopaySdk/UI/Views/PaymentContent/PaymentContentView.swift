//
//  PaymentContentView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct PaymentContentView: View {
    @EnvironmentObject private var colorManager: ColorManager
    @StateObject private var viewModel: PaymentContentViewModel = .init()

    var body: some View {
        VStack {
            content
            webViewNavigationLink
        }
        .background(colorManager.neutralLightColor)
        .fullScreenCover(
            isPresented: $viewModel.shouldShowPaymentStatus,
            content: {
                if let viewModel = viewModel.paymentStatusViewModel {
                    PaymentStatusView(viewModel: viewModel, isPresented: $viewModel.shouldShowPaymentStatus) {
                        self.viewModel.redirectUrl = nil
                    }
                }
            }
        )
        .navigationTitle(viewModel.navigationTitle)
    }
    
    @ViewBuilder
    var content: some View {
        if #available(iOS 17.0, *) {
            ScrollView {
                paymentView
            }
            .contentMargins(.bottom, 48)
        } else {
            ScrollView {
                paymentView
            }
            .safeAreaInset(edge: .bottom) {
                Spacer()
                    .frame(height: 48)
            }
        }
    }
    
    var paymentView: some View {
        APGatewayListView(
            data: APGatewayBaseViewModelData(
                config: SdkConfigManager.shared.config,
                amount: Double(SdkConfigManager.shared.param(for: .price).replacingOccurrences(of: ",", with: ".")) ?? 29.00,
                summary: SdkConfigManager.shared.param(for: .paymentSummary),
                customerEmail: SdkConfigManager.shared.param(for: .email),
                paymentViewCallback: { result, error in
                    viewModel.transactionCompleted(result: result, error: error)
                },
                tokenExpiredCallback: { error in
                    // Display progress, refresh token, update it by using:
                    // config.setToken(token: "new_token_here")
                    // And let user use retry button or pay button
                }
            )) { viewModel.setSelectedPaymentGroup($0) }
            .background(colorManager.neutralLightColor)
            .environmentObject(colorManager.styleManager)
    }
    
    var webViewNavigationLink: some View {
        NavigationLink(
            destination: webView,
            isActive: $viewModel.shouldShowWebView
        ) {}
            .accessibilityHidden(true)
    }

    var webView: some View {
        RedirectWebView(url: viewModel.redirectUrl) { result, error in
            viewModel.webViewCompleted(result: result, error: error)
        }
    }
}
