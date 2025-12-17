//
//  PaymentStatusViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import Combine
import SwiftUI

@MainActor
class PaymentStatusViewModel: ObservableObject {
    @Published private(set) var status: PaymentStatus

    private(set) var paymentStatus: APPaymentStatus?
    private let orderId: String?
    private var repeatCount: Int = 0
    private var task: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()

    init(orderId: String?, status: PaymentStatus? = nil) {
        self.orderId = orderId
        self.status = status ?? .pending
        observeAppLifecycle()
    }

    func startTask() {
        task = Task {
            await self.getOrderStatus()
        }
    }

    private func observeAppLifecycle() {
        let center = NotificationCenter.default
        center.publisher(for: UIApplication.willResignActiveNotification)
            .sink { [weak self] _ in
                self?.task?.cancel()
                self?.task = nil
            }
            .store(in: &cancellables)

        center.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.startTask()
            }
            .store(in: &cancellables)
    }

    private func getOrderStatus() async {
        guard let orderId, paymentStatus == .pending || paymentStatus == nil else { return }
        do {
            let result = try await Autopay(config: SdkConfigManager.shared.config).getTransactionStatus(orderId: orderId)
            status = .init(apStatus: result.paymentStatus)
            paymentStatus = result.paymentStatus
            // Just as an example, recalling checking status if there are some pending transactions
            if result.paymentStatus == .pending, repeatCount < 10 {
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                repeatCount += 1
                await getOrderStatus()
            }
        } catch {
            if Task.isCancelled { return }
            status = .failure(message: (error as? APError)?.message ?? "demo_general_error")
            paymentStatus = .failure
        }
    }
}
