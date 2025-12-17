//
//  TextFieldServiceConfigView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct TextFieldServiceConfigView: View {
    @EnvironmentObject private var colorManager: ColorManager
    let type: ServiceConfigType
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(type.titleKey))
                .customScaledFont(.labelLarge)
                .accessibilityHidden(true)
            TextField("", text: $value)
                .keyboardType(type.keyboardType)
                .customScaledFont(.inputLarge)
                .padding(16)
                .background(colorManager.backgroundColor)
                .cornerRadius(48)
                .overlay(
                    RoundedRectangle(cornerRadius: 48)
                        .stroke(colorManager.borderColor, lineWidth: 1)
                )
                .accessibilityLabel(LocalizedStringKey(type.titleKey))
        }
    }
}
