//
//  ThemeViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import Combine
import SwiftUI

enum ThemeType: String, CaseIterable {
    case light
    case dark

    var titleKey: String {
        "demo_theme_\(self)"
    }
}

@MainActor
class ThemeViewModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published private(set) var brandColorViewModel: BrandColorViewModel
    @Published private(set) var extraLightColorViewModels: [TextFieldColorViewModel] = []
    @Published private(set) var extraDarkColorViewModels: [TextFieldColorViewModel] = []
    @Published var themeType: ThemeType = .light
    private var colorManager: ColorManager?
    private var bag = Set<AnyCancellable>()

    init() {
        extraLightColorViewModels = ColorFieldType.allCases.compactMap { type in
            .init(type: type, theme: .light)
        }
        extraDarkColorViewModels = ColorFieldType.allCases.compactMap { type in
            .init(type: type, theme: .dark)
        }

        brandColorViewModel = BrandColorViewModel(brandColors: [
            .light: DesignConfig.default.brandColor.light,
            .dark: DesignConfig.default.brandColor.dark,
        ])

        $themeType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] themeType in
                self?.brandColorViewModel.themeType = themeType
            }
            .store(in: &bag)
    }

    func didPressSaveButton() {
        let designConfig = DesignConfig(
            brandColor: APColor(
                light: brandColorViewModel.colors[.light] ?? DesignConfig.default.brandColor.light,
                dark: brandColorViewModel.colors[.dark] ?? DesignConfig.default.brandColor.dark
            ),
            contentColor: getColor(for: .content),
            neutralLightColor: getColor(for: .neutralLight),
            neutralDarkColor: getColor(for: .neutralDark),
            errorColor: getColor(for: .error),
            backgroundColor: getColor(for: .background),
            textColor: getColor(for: .text)
        )
        colorManager?.updateConfig(designConfig)
    }

    func setColorManager(manager: ColorManager) {
        colorManager = manager
        updateColors()
    }

    func setTheme(_ type: ColorScheme) {
        themeType = type == .light ? .light : .dark
    }

    private func updateColors() {
        guard let colorManager else {
            return
        }

        brandColorViewModel.set(colors: [
            .light: colorManager.config.brandColor.light,
            .dark: colorManager.config.brandColor.dark,
        ])

        for model in extraLightColorViewModels {
            switch model.type {
            case .content:
                model.updateColor(color: colorManager.config.contentColor.light.toHex())
            case .neutralLight:
                model.updateColor(color: colorManager.config.neutralLightColor.light.toHex())
            case .neutralDark:
                model.updateColor(color: colorManager.config.neutralDarkColor.light.toHex())
            case .error:
                model.updateColor(color: colorManager.config.errorColor.light.toHex())
            case .background:
                model.updateColor(color: colorManager.config.backgroundColor.light.toHex())
            case .text:
                model.updateColor(color: colorManager.config.textColor.light.toHex())
            }
        }

        for model in extraDarkColorViewModels {
            switch model.type {
            case .content:
                model.updateColor(color: colorManager.config.contentColor.dark.toHex())
            case .neutralLight:
                model.updateColor(color: colorManager.config.neutralLightColor.dark.toHex())
            case .neutralDark:
                model.updateColor(color: colorManager.config.neutralDarkColor.dark.toHex())
            case .error:
                model.updateColor(color: colorManager.config.errorColor.dark.toHex())
            case .background:
                model.updateColor(color: colorManager.config.backgroundColor.dark.toHex())
            case .text:
                model.updateColor(color: colorManager.config.textColor.dark.toHex())
            }
        }
    }

    private func getColor(for type: ColorFieldType) -> APColor {
        let lightColor = extraLightColorViewModels.first(where: { $0.type == type })?.color
        let darkColor = extraDarkColorViewModels.first(where: { $0.type == type })?.color
        switch type {
        case .content:
            return APColor(light: lightColor ?? DesignConfig.default.contentColor.light,
                           dark: darkColor ?? DesignConfig.default.contentColor.dark)
        case .neutralLight:
            return APColor(light: lightColor ?? DesignConfig.default.neutralLightColor.light,
                           dark: darkColor ?? DesignConfig.default.neutralLightColor.dark)
        case .neutralDark:
            return APColor(light: lightColor ?? DesignConfig.default.neutralDarkColor.light,
                           dark: darkColor ?? DesignConfig.default.neutralDarkColor.dark)
        case .error:
            return APColor(light: lightColor ?? DesignConfig.default.errorColor.light,
                           dark: darkColor ?? DesignConfig.default.errorColor.dark)
        case .background:
            return APColor(light: lightColor ?? DesignConfig.default.backgroundColor.light,
                           dark: darkColor ?? DesignConfig.default.backgroundColor.dark)
        case .text:
            return APColor(light: lightColor ?? DesignConfig.default.textColor.light,
                           dark: darkColor ?? DesignConfig.default.textColor.dark)
        }
    }
}
