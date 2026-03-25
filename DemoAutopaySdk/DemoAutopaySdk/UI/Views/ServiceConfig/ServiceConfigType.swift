//
//  ServiceConfigType.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import UIKit

enum ServiceConfigType: String, CaseIterable {
    case token
    case serviceId
    case acceptorId
    case price
    case paymentSummary
    case applePayMerchantId
    case environment
    case method
    case email
    case currency
    case contextPath

    var titleKey: String {
        switch self {
        case .serviceId:
            "demo_service_config_service_id"
        case .acceptorId:
            "demo_service_config_acceptor_id"
        case .paymentSummary:
            "demo_service_config_payment_summary"
        case .contextPath:
            "demo_service_config_context_path"
        default:
            "demo_service_config_\(self)"
        }
    }

    static var editable: [ServiceConfigType] {
        [
            .token,
            .serviceId,
            .acceptorId,
            .contextPath,
            .price,
            .currency,
            .paymentSummary,
        ]
    }
    
    var isRequired: Bool {
        switch self {
        case .paymentSummary:
            false
        default:
            true
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .price: .decimalPad
        default: .default
        }
    }
}
