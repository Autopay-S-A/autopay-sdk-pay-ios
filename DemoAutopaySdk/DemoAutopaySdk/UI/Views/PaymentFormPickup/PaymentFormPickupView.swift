//
//  PaymentFormPickupView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct PaymentFormPickupView: View {
    @EnvironmentObject private var colorManager: ColorManager
    @Environment(\.dismiss) var dismiss
    @State private var selectedType = PaymentFormType(rawValue: SdkConfigManager.shared.param(for: .method)) ?? .native

    var body: some View {
        ZStack {
            colorManager.neutralLightColor.ignoresSafeArea()
            VStack(spacing: 12) {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 12) {
                            Text("demo_type_title")
                                .customScaledFont(.labelXLarge)
                                .multilineTextAlignment(.center)
                            Text("demo_type_content")
                                .customScaledFont(.pSmall)
                                .multilineTextAlignment(.center)
                        }
                        VStack(spacing: 12) {
                            ForEach(PaymentFormType.allCases, id: \.hashValue) { type in
                                PaymentFormTypeView(type: type, selectedType: $selectedType).onTapGesture {
                                    selectedType = type
                                }
                            }
                        }
                    }
                    .padding(16)
                }
                saveButton
                    .padding([.leading, .trailing], 16)
                VersionView()
                    .padding([.bottom, .leading, .trailing], 16)
            }.navigationTitle("demo_list_title")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var saveButton: some View {
        Button(action: {
            SdkConfigManager.shared.saveParam(.method, selectedType.rawValue)
            dismiss()
        }, label: {
            Text("demo_common_save")
        })
        .buttonStyle(PrimaryButtonStyle(type: .primary,
                                        size: .large))
    }
}

#Preview {
    PaymentFormPickupView()
}
