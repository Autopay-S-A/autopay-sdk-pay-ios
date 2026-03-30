//
//  HomeScreenViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import Foundation

@MainActor
final class HomeScreenViewModel: ObservableObject {
    @Published var shouldShowPaymentStatus = false
    @Published private(set) var paymentStatusViewModel: PaymentStatusViewModel?
    @Published private(set) var isLoading = false

    func webMethodDidEnd(orderId: String?, result: APResult?, error: APError?) {
        defer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.shouldShowPaymentStatus = true
            }
        }

        if let result {
            paymentStatusViewModel = .init(orderId: orderId, status: .init(apStatus: result.status))
        } else if let error {
            paymentStatusViewModel = .init(orderId: nil, status: .failure(message: error.message))
        } else if let orderId {
            paymentStatusViewModel = .init(orderId: orderId)
        } else {
            paymentStatusViewModel = .init(orderId: nil, status: .failure())
        }
    }
}
