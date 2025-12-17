//
//  PaymentFormType.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//
import Foundation

enum PaymentFormType: String, CaseIterable {
    case native
    case webview

    var titleKey: String {
        "demo_home_form_\(self)"
    }

    var imageName: String {
        "\(self)_payment_method"
    }

    var descriptionKey: String {
        "demo_home_form_\(self)_explanation"
    }
}
