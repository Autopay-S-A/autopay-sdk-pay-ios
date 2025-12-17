//
//  WebMethodViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import Foundation

@MainActor
final class WebMethodViewModel: ObservableObject {
    @Published private(set) var webViewUrl: URL?
    @Published private(set) var state: ViewState = .loading
    @Published var shouldShowWebView = true

    var transactionCallback: (_ orderId: String?, _ result: APResult?, _ error: APError?) -> Void

    private var orderId: String?

    init(transactionCallback: @escaping (_ orderId: String?, _ result: APResult?, _ error: APError?) -> Void) {
        self.transactionCallback = transactionCallback
    }

    func performWebViewMethod() async {
        state = .loading
        let price = Double(SdkConfigManager.shared.param(for: .price).replacingOccurrences(of: ",", with: "."))
        let transactionData = APTransactionData(amount: price ?? 29.00)
        transactionData.setGatewayId(0)

        do {
            let transaction = try await Autopay(config: SdkConfigManager.shared.config).startTransaction(transactionData: transactionData)
            orderId = transaction.orderId
            if let redirectUrlString = transaction.redirectUrl, let redirectUrl = URL(string: redirectUrlString) {
                webViewUrl = redirectUrl
            }
            state = .content

        } catch {
            state = .error(
                ErrorState(error: error) { [weak self] in
                    Task { [weak self] in
                        await self?.performWebViewMethod()
                    }
                }
            )
        }
    }

    func cardPaymentDidEnd(result: APResult?, error: APError?) {
        shouldShowWebView = false
        transactionCallback(orderId, result, error)
    }
}
