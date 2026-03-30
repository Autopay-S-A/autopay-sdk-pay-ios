//
//  PaymentContentViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import Combine
import SwiftUI

@MainActor
class PaymentContentViewModel: ObservableObject {
    @Published private(set) var navigationTitle: LocalizedStringKey = "demo_list_title"
    @Published var redirectUrl: URL? = nil
    @Published var shouldShowPaymentStatus: Bool = false
    @Published var shouldShowWebView: Bool = false
    @Published var viewType: PaymentViewType

    private var orderId: String?
    private var error: APError?
    private var subscriptions = Set<AnyCancellable>()

    init(viewType: PaymentViewType) {
        self.viewType = viewType
        setupBinding()
    }

    var paymentStatusViewModel: PaymentStatusViewModel? {
        guard let orderId, error == nil else {
            return .init(orderId: nil, status: .failure(message: error?.message))
        }
        return .init(orderId: orderId)
    }

    func transactionCompleted(result: AutopaySdk.APTransaction?, error: APError?) {
        clearState()
        guard let result = result else {
            if let error {
                self.error = error
                shouldShowPaymentStatus = true
            }
            return
        }
        if let redirectUrl = result.redirectUrl, let url = URL(string: redirectUrl) {
            self.redirectUrl = url
        }

        orderId = result.orderId

        if redirectUrl == nil {
            shouldShowPaymentStatus = true
        }
    }

    func webViewCompleted(result _: APResult?, error: APError?) {
        redirectUrl = nil
        if let error {
            self.error = error
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.shouldShowPaymentStatus = true
        }
    }

    func setSelectedPaymentGroup(_ paymentGroup: APGatewayPaymentGroup?) {
        switch paymentGroup {
        case .applePay: navigationTitle = "demo_apple_pay_title"
        case .bankTransfer: navigationTitle = "demo_bank_title"
        case .blik: navigationTitle = "demo_blik_title"
        case .card: navigationTitle = "demo_card_title"
        case .visa: navigationTitle = "demo_visa_title"
        default: navigationTitle = "demo_list_title"
        }
    }

    private func setupBinding() {
        $redirectUrl.sink { [weak self] url in
            self?.shouldShowWebView = url != nil
        }.store(in: &subscriptions)
    }

    func clearState() {
        orderId = nil
        redirectUrl = nil
        error = nil
    }
}
