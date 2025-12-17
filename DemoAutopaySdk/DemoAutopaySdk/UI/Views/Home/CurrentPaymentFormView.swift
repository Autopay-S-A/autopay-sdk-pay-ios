//
//  CurrentPaymentFormView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct CurrentPaymentFormTypeView: View {
    @EnvironmentObject private var colorManager: ColorManager
    @ObservedObject private var config = SdkConfigManager.shared

    var body: some View {
        Group {
            VStack(spacing: 12) {
                if config.param(for: .method) == PaymentFormType.native.rawValue {
                    Image("native_payment_method")
                        .foregroundStyle(colorManager.brandColor)
                        .frame(width: 45, height: 40)
                    Text("demo_home_form_native")
                        .customScaledFont(.labelXLarge)
                    Text("demo_home_form_native_explanation")
                        .customScaledFont(.pSmall)
                        .multilineTextAlignment(.center)
                } else {
                    Image("webview_payment_method")
                        .foregroundStyle(colorManager.brandColor)
                        .frame(width: 45, height: 40)
                    Text("demo_home_form_webview")
                        .customScaledFont(.labelXLarge)
                    Text("demo_home_form_webview_explanation")
                        .customScaledFont(.pSmall)
                        .multilineTextAlignment(.center)
                }
            }
            .accessibilityElement(children: .combine)
            .frame(maxWidth: .infinity)
            .padding(24)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(colorManager.neutralLightColor)
        )
    }
}

#Preview {
    CurrentPaymentFormTypeView()
}
