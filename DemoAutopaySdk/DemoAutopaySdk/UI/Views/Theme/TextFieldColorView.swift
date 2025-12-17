//
//  TextFieldColorView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct TextFieldColorView: View {
    @EnvironmentObject private var colorManager: ColorManager
    @StateObject var viewModel: TextFieldColorViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(viewModel.type.titleKey))
                .customScaledFont(.labelLarge)
                .accessibilityHidden(true)
            HStack(spacing: 12) {
                TextField("#FFFFFF", text: $viewModel.textColor, onEditingChanged: { _ in viewModel.validateOnSubmit() })
                    .accessibilityLabel(LocalizedStringKey(viewModel.type.titleKey))
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    .customScaledFont(.inputLarge)
                    .padding(16)
                    .background(colorManager.backgroundColor)
                    .cornerRadius(48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .stroke(colorManager.borderColor, lineWidth: 1)
                    )
                    .onChange(of: viewModel.textColor) { _ in
                        viewModel.validate()
                    }
                Circle()
                    .fill(viewModel.color)
                    .frame(width: 48, height: 48)
                    .shadow(color: Color(hex: "#282828").opacity(0.2),
                            radius: 6,
                            x: 0,
                            y: 4)
            }
        }
    }
}

#Preview {
    TextFieldColorView(viewModel: .init(type: .background, theme: .dark))
}
