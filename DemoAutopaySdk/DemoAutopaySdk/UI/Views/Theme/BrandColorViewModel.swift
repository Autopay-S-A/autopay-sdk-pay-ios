//
//  BrandColorViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

@MainActor
class BrandColorViewModel: ObservableObject {
    @Published private(set) var selectedType = [ThemeType: ThemeBrandColorType?]()
    @Published private(set) var colorText = [ThemeType: String?]()
    @Published var themeType: ThemeType
    private var oldValues = [ThemeType: String?]()

    init(brandColors: [ThemeType: Color]) {
        themeType = .light

        for (themeType, color) in brandColors {
            if let selectedType = ThemeBrandColorType(rawValue: color.toHex() ?? "") {
                self.selectedType[themeType] = selectedType
            } else {
                selectedType[themeType] = nil
            }
            colorText[themeType] = color.toHex()
            oldValues[themeType] = color.toHex()
        }
    }

    var isCustomColorValid: Bool {
        guard selectedType[themeType] == nil else {
            return false
        }
        guard let text = colorText[themeType], let text, !text.isEmpty else {
            return false
        }
        let pattern = "^#([A-Fa-f0-9]{6})$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex?.firstMatch(in: text, options: [], range: range) != nil
    }

    func onTapColor(type: ThemeBrandColorType) {
        colorText[themeType] = type.rawValue
        selectedType[themeType] = type
    }

    func setColorText(_ text: String?) {
        if let standardColor = ThemeBrandColorType.allCases.first(where: { $0.rawValue == text }) {
            selectedType[themeType] = standardColor
        } else if let text = text, !text.isEmpty {
            selectedType[themeType] = nil
            colorText[themeType] = text
        }
    }

    func set(colors: [ThemeType: Color?]) {
        for (themeTypeKey, colorValue) in colors {
            if let standardColor = ThemeBrandColorType.allCases.first(where: { $0.rawValue == colorValue?.toHex() }) {
                selectedType[themeTypeKey] = standardColor
                colorText[themeTypeKey] = standardColor.rawValue
            } else if let hexText = colorValue?.toHex(), !hexText.isEmpty {
                selectedType[themeTypeKey] = nil
                colorText[themeTypeKey] = hexText
            } else {
                selectedType[themeTypeKey] = ThemeBrandColorType.blue
                colorText[themeTypeKey] = ThemeBrandColorType.blue.rawValue
            }
        }
    }

    var colors: [ThemeType: Color] {
        var colors = [ThemeType: Color]()

        for (themeTypeKey, textColorValue) in colorText {
            if let selectedType = selectedType[themeTypeKey], let selectedType {
                colors[themeTypeKey] = selectedType.color
            } else if let textColorValue {
                if textColorValue.count < 7 {
                    colors[themeTypeKey] = Color(hex: (oldValues[themeTypeKey] ?? "") ?? "")
                } else {
                    colors[themeTypeKey] = Color(hex: textColorValue)
                }
            } else {
                colors[themeTypeKey] = ThemeBrandColorType.blue.color
            }
        }

        return colors
    }

    func validate() {
        guard let stringValue = colorText[themeType], let _ = stringValue else { return }

        let containsHash = colorText[themeType]!!.contains("#")

        if colorText[themeType]!!.count == 1 && colorText[themeType] == "#" {
            return
        }
        if colorText[themeType]!!.count > 7 {
            colorText[themeType] = String(colorText[themeType]!!.prefix(7))
        }
        if colorText[themeType]!!.contains(where: { !"0123456789ABCDEF".contains($0) }) {
            colorText[themeType]!! = colorText[themeType]!!.map { "0123456789ABCDEF".contains($0) ? String($0) : "" }.reduce("", +)
        }
        if colorText[themeType]!!.count > 0 || containsHash {
            colorText[themeType]!! = "#" + colorText[themeType]!!.replacingOccurrences(of: "#", with: "")
        }
    }

    func validateOnSubmit() {
        guard let stringToValidate = colorText[themeType], let colorToValidate = stringToValidate else { return }

        if colorToValidate.count < 7 {
            colorText[themeType] = oldValues[themeType]
        }
    }
}
