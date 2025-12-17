//
//  BrandColorView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct BrandColorView: View {
    @EnvironmentObject private var colorManager: ColorManager
    @ObservedObject var viewModel: BrandColorViewModel

    var body: some View {
        VStack(spacing: 16) {
            themeBrandColorView
            VStack(alignment: .leading, spacing: 8) {
                Text("demo_theme_brand_insert_hex")
                    .customScaledFont(.labelLarge)
                    .accessibilityHidden(true)
                TextField("#FFFFFF", text: Binding(
                    get: { (viewModel.colorText[viewModel.themeType] ?? "") ?? "" },
                    set: { viewModel.setColorText($0) }
                ), onEditingChanged: { _ in viewModel.validateOnSubmit() })
                    .accessibilityLabel(LocalizedStringKey("demo_theme_brand_color_title"))
                    .accessibilityHint(LocalizedStringKey("demo_theme_brand_insert_hex"))
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    .customScaledFont(.inputLarge)
                    .padding(16)
                    .background(content: {
                        ZStack {
                            colorManager.backgroundColor
                            if viewModel.isCustomColorValid {
                                HStack {
                                    Spacer()
                                    Image("checkmark_icon")
                                        .foregroundStyle(colorManager.brandColor)
                                        .frame(width: 16, height: 16)
                                        .padding(16)
                                }
                            }
                        }
                    })
                    .cornerRadius(48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .stroke(colorManager.borderColor, lineWidth: 1)
                    )
                    .onChange(of: viewModel.colorText) { _ in
                        viewModel.validate()
                    }
            }
        }
    }

    var themeBrandColorView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("demo_theme_brand_color")
                .customScaledFont(.labelLarge)
            HStack {
                ForEach(ThemeBrandColorType.allCases, id: \.self) { colorType in
                    let selected = viewModel.selectedType[viewModel.themeType] == colorType
                    let color = colorType.color
                    Circle()
                        .fill(color)
                        .frame(idealWidth: 48, idealHeight: 48)
                        .shadow(
                            color: Colors.shadowColor.opacity(0.2),
                            radius: 6,
                            x: 0,
                            y: 4
                        )
                        .overlay(
                            Circle()
                                .stroke(colorManager.neutralLightColor, lineWidth: selected ? 3 : 0)
                        ).overlay(
                            Circle()
                                .stroke(colorManager.neutralDarkColor, lineWidth: selected ? 2 : 0)
                                .padding(-1.5)
                        )
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            viewModel.onTapColor(type: colorType)
                        }
                        .accessibilityAddTraits(.isButton)
                        .accessibilityAddTraits(selected ? .isSelected : .isButton)
                        .accessibilityLabel(color.toHex() ?? "")
                }
            }
        }
    }
}

#Preview {
    BrandColorView(viewModel: BrandColorViewModel(brandColors: [
        .light: DesignConfig.default.brandColor.light,
        .dark: DesignConfig.default.brandColor.dark,
    ]))
}
