//
//  ColorManager.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

final class ColorManager: ObservableObject {
    @Published private(set) var brandColor: Color
    @Published private(set) var contentColor: Color
    @Published private(set) var neutralLightColor: Color
    @Published private(set) var neutralDarkColor: Color
    @Published private(set) var errorColor: Color
    @Published private(set) var backgroundColor: Color
    @Published private(set) var textColor: Color
    @Published private(set) var contentDisabledColor: Color
    @Published private(set) var brandDisabledColor: Color
    @Published private(set) var borderColor: Color

    @Published private(set) var config: DesignConfig = .default {
        didSet {
            styleManager.update(with: config)
        }
    }
    
    @Published private(set) var styleManager: APStyleManager = .init()

    init(designConfig: DesignConfig = .default) {
        let savedConfigDictionary = UserDefaults.standard.dictionary(forKey: UserDefaultsKeys.designConfig.rawValue) as? [String: [String: String]]
        let config: DesignConfig
        if let savedConfigDictionary {
            config = DesignConfig.fromDictionaryRepresentation(savedConfigDictionary, defaultValues: designConfig)
        } else {
            config = designConfig
        }

        brandColor = config.brandColor.color
        contentColor = config.contentColor.color
        neutralLightColor = config.neutralLightColor.color
        neutralDarkColor = config.neutralDarkColor.color
        errorColor = config.errorColor.color
        backgroundColor = config.backgroundColor.color
        textColor = config.textColor.color
        contentDisabledColor = config.brandColor.color.opacity(0.4)
        brandDisabledColor = config.brandColor.color.opacity(0.4)
        borderColor = config.neutralDarkColor.color.opacity(0.2)
        self.config = config
    }

    func updateConfig(_ designConfig: DesignConfig) {
        brandColor = designConfig.brandColor.color
        contentColor = designConfig.contentColor.color
        neutralLightColor = designConfig.neutralLightColor.color
        neutralDarkColor = designConfig.neutralDarkColor.color
        errorColor = designConfig.errorColor.color
        backgroundColor = designConfig.backgroundColor.color
        textColor = designConfig.textColor.color
        contentDisabledColor = designConfig.contentColor.color.opacity(0.4)
        brandDisabledColor = designConfig.brandColor.color.opacity(0.4)
        borderColor = config.neutralDarkColor.color.opacity(0.2)
        config = designConfig

        UserDefaults.standard.set(designConfig.dictionaryRepresentation, forKey: UserDefaultsKeys.designConfig.rawValue)
    }
}

extension APStyleManager {
    
    func update(with designConfig: DesignConfig) {
        typography.defaultTextColor = designConfig.textColor
        
        primaryButtonStyle.containerColor = designConfig.brandColor
        primaryButtonStyle.containerInactiveColor = .init(
            light: designConfig.brandColor.light.opacity(0.4),
            dark: designConfig.brandColor.dark.opacity(0.4)
        )
        primaryButtonStyle.textStyle.color = .init(
            light: designConfig.textColor.dark
        )
        primaryButtonStyle.textInactiveStyle.color = .init(
            light: designConfig.textColor.dark.opacity(0.7)
        )
        
        secondaryButtonStyle.borderColor = designConfig.brandColor
        secondaryButtonStyle.borderInactiveColor = .init(
            light: designConfig.brandColor.light.opacity(0.4),
            dark: designConfig.brandColor.dark.opacity(0.4)
        )
        secondaryButtonStyle.textStyle.color = designConfig.brandColor
        secondaryButtonStyle.textInactiveStyle.color = .init(
            light: designConfig.brandColor.light.opacity(0.4),
            dark: designConfig.brandColor.dark.opacity(0.4)
        )
        
        tertiaryButtonStyle.borderColor = designConfig.brandColor
        tertiaryButtonStyle.borderInactiveColor = .init(
            light: designConfig.brandColor.light.opacity(0.4),
            dark: designConfig.brandColor.dark.opacity(0.4)
        )
        tertiaryButtonStyle.textStyle.color = designConfig.brandColor
        tertiaryButtonStyle.textInactiveStyle.color = .init(
            light: designConfig.brandColor.light.opacity(0.4),
            dark: designConfig.brandColor.dark.opacity(0.4)
        )
        
        paymentMethodButtonStyle.containerColor = designConfig.backgroundColor
        paymentMethodButtonStyle.borderColor = .init(
            light: designConfig.neutralDarkColor.light.opacity(0.2),
            dark: designConfig.neutralDarkColor.dark.opacity(0.2)
        )
        paymentMethodButtonStyle.textStyle.color = designConfig.textColor
        
        bankGridStyle.backgroundColor = designConfig.backgroundColor
        bankGridStyle.checkedBorderColor = designConfig.brandColor
        bankGridStyle.uncheckedBorderColor = .init(
            light: designConfig.neutralDarkColor.light.opacity(0.4),
            dark: designConfig.neutralDarkColor.dark.opacity(0.4)
        )
        
        checkboxStyle.checkedColor = designConfig.brandColor
        checkboxStyle.uncheckedColor = designConfig.neutralDarkColor
        checkboxStyle.errorColor = designConfig.errorColor
        
        dccPaymentFormStyle.selectedBorderColor = designConfig.brandColor
        dccPaymentFormStyle.unselectedBorderColor = .init(
            light: designConfig.neutralDarkColor.light.opacity(0.2),
            dark: designConfig.neutralDarkColor.dark.opacity(0.2)
        )
        dccPaymentFormStyle.cellBackgroundColor = designConfig.backgroundColor
        
        dialogStyle.dialogBackgroundColor = designConfig.neutralLightColor
        
        loaderStyle.color = designConfig.brandColor
        
        paymentMethodTitleStyle.backgroundColor = designConfig.backgroundColor
        paymentMethodTitleStyle.iconColor = designConfig.textColor
        paymentMethodTitleStyle.textStyle.color = designConfig.textColor
        
        paymentSummaryStyle.backgroundColor = designConfig.backgroundColor
        paymentSummaryStyle.dividerColor = .init(
            light: designConfig.neutralDarkColor.light.opacity(0.2),
            dark: designConfig.neutralDarkColor.dark.opacity(0.2)
        )
        
        radioButtonStyle.checkedColor = designConfig.brandColor
        radioButtonStyle.uncheckedColor = designConfig.neutralDarkColor
        
        switchStyle.checkedThumbColor = designConfig.contentColor
        switchStyle.uncheckedThumbColor = designConfig.neutralDarkColor
        switchStyle.checkedTrackColor = designConfig.brandColor
        switchStyle.uncheckedTrackColor = designConfig.backgroundColor
        switchStyle.uncheckedBorderColor = designConfig.neutralDarkColor
        
        textInputStyle.inputTextStyle.color = designConfig.textColor
        textInputStyle.labelTextStyle.color = designConfig.textColor
        textInputStyle.errorTextStyle.color = designConfig.errorColor
        textInputStyle.borderInactiveColor = .init(
            light: designConfig.neutralDarkColor.light.opacity(0.4),
            dark: designConfig.neutralDarkColor.dark.opacity(0.4)
        )
        textInputStyle.borderActiveColor = designConfig.brandColor
        textInputStyle.borderErrorColor = designConfig.errorColor
        textInputStyle.backgroundColor = designConfig.backgroundColor
        textInputStyle.trailingIconsColor = designConfig.textColor
        
        errorColor = designConfig.errorColor
        footerIconsColor = designConfig.neutralDarkColor
    }
    
}

extension APColor {
    var color: Color {
        Color(light: self.light, dark: self.dark)
    }

    fileprivate var dictionaryRepresentation: [String: String?] {
        [ColorsDictionaryKeys.light.rawValue: light.toHex(), ColorsDictionaryKeys.dark.rawValue: dark.toHex()]
    }

    fileprivate static func fromDictionaryRepresentation(_ dictionary: [String: String?]?) -> APColor? {
        if let lightColorString = dictionary?[ColorsDictionaryKeys.light.rawValue] as? String,
           let darkColorString = dictionary?[ColorsDictionaryKeys.dark.rawValue] as? String
        {
            return APColor(light: Color(hex: lightColorString), dark: Color(hex: darkColorString))
        }

        return nil
    }
}

private enum ColorsDictionaryKeys: String {
    case brandColor
    case contentColor
    case neutralLightColor
    case neutralDarkColor
    case errorColor
    case backgroundColor
    case textColor

    case light
    case dark
}

private extension DesignConfig {
    var dictionaryRepresentation: [String: [String: String?]] {
        var dictionary = [String: [String: String?]]()

        dictionary[ColorsDictionaryKeys.brandColor.rawValue] = brandColor.dictionaryRepresentation
        dictionary[ColorsDictionaryKeys.contentColor.rawValue] = contentColor.dictionaryRepresentation
        dictionary[ColorsDictionaryKeys.neutralLightColor.rawValue] = neutralLightColor.dictionaryRepresentation
        dictionary[ColorsDictionaryKeys.neutralDarkColor.rawValue] = neutralDarkColor.dictionaryRepresentation
        dictionary[ColorsDictionaryKeys.errorColor.rawValue] = errorColor.dictionaryRepresentation
        dictionary[ColorsDictionaryKeys.backgroundColor.rawValue] = backgroundColor.dictionaryRepresentation
        dictionary[ColorsDictionaryKeys.textColor.rawValue] = textColor.dictionaryRepresentation

        return dictionary
    }

    static func fromDictionaryRepresentation(_ dictionary: [String: [String: String?]], defaultValues: DesignConfig) -> Self {
        let brandColor = APColor.fromDictionaryRepresentation(dictionary[ColorsDictionaryKeys.brandColor.rawValue])
        let contentColor = APColor.fromDictionaryRepresentation(dictionary[ColorsDictionaryKeys.contentColor.rawValue])
        let neutralLightColor = APColor.fromDictionaryRepresentation(dictionary[ColorsDictionaryKeys.neutralLightColor.rawValue])
        let neutralDarkColor = APColor.fromDictionaryRepresentation(dictionary[ColorsDictionaryKeys.neutralDarkColor.rawValue])
        let errorColor = APColor.fromDictionaryRepresentation(dictionary[ColorsDictionaryKeys.errorColor.rawValue])
        let backgroundColor = APColor.fromDictionaryRepresentation(dictionary[ColorsDictionaryKeys.backgroundColor.rawValue])
        let textColor = APColor.fromDictionaryRepresentation(dictionary[ColorsDictionaryKeys.textColor.rawValue])

        let config = Self(
            brandColor: brandColor ?? defaultValues.brandColor,
            contentColor: contentColor ?? defaultValues.contentColor,
            neutralLightColor: neutralLightColor ?? defaultValues.neutralLightColor,
            neutralDarkColor: neutralDarkColor ?? defaultValues.neutralDarkColor,
            errorColor: errorColor ?? defaultValues.errorColor,
            backgroundColor: backgroundColor ?? defaultValues.backgroundColor,
            textColor: textColor ?? defaultValues.textColor
        )

        return config
    }
}
