//
//  TextFieldColorViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

enum ColorFieldType: CaseIterable {
    case content
    case neutralLight
    case neutralDark
    case error
    case background
    case text

    var titleKey: String {
        switch self {
        case .neutralDark:
            "demo_theme_neutral_dark_color"
        case .neutralLight:
            "demo_theme_neutral_light_color"
        default:
            "demo_theme_\(self)_color"
        }
    }

    var defaultValue: APColor {
        switch self {
        case .content:
            SdkConfigManager.shared.designConfig.contentColor
        case .neutralLight:
            SdkConfigManager.shared.designConfig.neutralLightColor
        case .neutralDark:
            SdkConfigManager.shared.designConfig.neutralDarkColor
        case .error:
            SdkConfigManager.shared.designConfig.errorColor
        case .background:
            SdkConfigManager.shared.designConfig.backgroundColor
        case .text:
            SdkConfigManager.shared.designConfig.textColor
        }
    }
}

@MainActor
class TextFieldColorViewModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published private(set) var type: ColorFieldType
    @Published private(set) var theme: ThemeType
    @Published var textColor: String
    private var oldValue: String

    init(type: ColorFieldType, theme: ThemeType) {
        self.type = type
        self.theme = theme
        let textColor = (theme == .light ? type.defaultValue.light : type.defaultValue.dark).toHex() ?? ""
        self.textColor = textColor
        oldValue = textColor
    }

    var color: Color {
        guard !textColor.isEmpty else {
            return theme == .light ? type.defaultValue.light : type.defaultValue.dark
        }
        guard textColor.count == 7 else {
            return Color(hex: oldValue)
        }

        return Color(hex: textColor)
    }

    func validate() {
        let containsHash = textColor.contains("#")

        if textColor.count == 1 && textColor == "#" {
            return
        }
        if textColor.count > 7 {
            textColor = String(textColor.prefix(7))
        }
        if textColor.contains(where: { !"0123456789ABCDEF".contains($0) }) {
            textColor = textColor.map { "0123456789ABCDEF".contains($0) ? String($0) : "" }.reduce("", +)
        }
        if textColor.count > 0 || containsHash {
            textColor = "#" + textColor.replacingOccurrences(of: "#", with: "")
        }
    }

    func validateOnSubmit() {
        if textColor.count < 7 {
            textColor = oldValue
        }
    }

    func updateColor(color: String?) {
        textColor = color ?? ""
        oldValue = color ?? ""
    }
}
