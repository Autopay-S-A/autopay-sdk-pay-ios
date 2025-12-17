//
//  PaymentStatus.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk

enum PaymentStatus {
    case success
    case pending
    case failure(message: String? = nil)
    
    init(apStatus: APPaymentStatus) {
        switch apStatus {
        case .success, .successMany:
            self = .success
        case .pending:
            self = .pending
        default:
            self = .failure()
        }
    }
    
    var imageName: String {
        switch self {
        case .success:
            "payment_status_success"
        case .pending:
            "payment_status_pending"
        case .failure:
            "payment_status_failure"
        }
    }

    var titleKey: String {
        switch self {
        case .success:
            return "demo_status_success"
        case .pending:
            return "demo_status_pending"
        case .failure(let message):
            guard let message else {
                return "demo_status_error"
            }
            return message
        }
    }
}
