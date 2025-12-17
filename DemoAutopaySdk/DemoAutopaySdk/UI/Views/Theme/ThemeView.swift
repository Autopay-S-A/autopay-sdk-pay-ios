//
//  ThemeView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

enum ThemeBrandColorType: String, CaseIterable {
    case blue = "#2E72BF"
    case red = "#EF4444"
    case orange = "#F97316"
    case yellow = "#FACC15"
    case green = "#4ADE80"
    case purple = "#3B82F6"

    var color: Color {
        Color(hex: rawValue)
    }
}

struct ThemeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var colorManager: ColorManager
    @StateObject private var viewModel: ThemeViewModel = .init()

    var body: some View {
        VStack(spacing: 12) {
            ScrollView {
                VStack(spacing: 24) {
                    themeTypeSection
                    brandColorSection
                    extraColorSection
                }
                .padding(16)
            }
            saveButton
                .padding([.leading, .trailing], 16)
            VersionView()
                .padding([.leading, .trailing, .bottom], 16)
        }
        .background(colorManager.neutralLightColor)
        .onAppear {
            viewModel.setColorManager(manager: colorManager)
            viewModel.setTheme(colorScheme)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("demo_theme_title")
    }

    private var themeTypeSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("demo_theme_type_title")
                .customScaledFont(.labelXLarge)
            HStack(alignment: .center) {
                ForEach(ThemeType.allCases, id: \.self) { type in
                    Button {
                        withAnimation {
                            viewModel.themeType = type
                        }
                    } label: {
                        Text(LocalizedStringKey(type.titleKey))
                    }.buttonStyle(
                        PrimaryButtonStyle(
                            type: viewModel.themeType == type ? .tertiary : .picker,
                            size: .picker
                        )
                    )
                    .accessibilityAddTraits(viewModel.themeType == type ? .isSelected : .isButton)
                }
            }
            .padding(6)
            .background(colorManager.backgroundColor)
            .cornerRadius(.infinity)
        }
    }

    private var brandColorSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("demo_theme_brand_color_title")
                .customScaledFont(.labelXLarge)
            BrandColorView(viewModel: viewModel.brandColorViewModel)
        }
    }

    private var extraColorSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("demo_theme_extra_color_title")
                .customScaledFont(.labelXLarge)
            VStack(spacing: 16) {
                switch viewModel.themeType {
                case .light:
                    ForEach(viewModel.extraLightColorViewModels) { viewModel in
                        TextFieldColorView(viewModel: viewModel)
                    }
                case .dark:
                    ForEach(viewModel.extraDarkColorViewModels) { viewModel in
                        TextFieldColorView(viewModel: viewModel)
                    }
                }
            }
        }
    }

    private var saveButton: some View {
        Button(action: {
            viewModel.didPressSaveButton()
            dismiss()
        }, label: {
            Text("demo_common_save")
        })
        .buttonStyle(PrimaryButtonStyle(type: .primary,
                                        size: .large))
    }
}

#Preview {
    ThemeView()
}
