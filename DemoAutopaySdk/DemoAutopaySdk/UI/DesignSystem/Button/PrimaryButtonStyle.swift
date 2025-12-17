//
//  PrimaryButtonStyle.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

enum PrimaryButtonType {
    case primary
    case tertiary
    case clear
    case paymentMethod
    case picker

    var borderWidth: CGFloat {
        switch self {
        case .primary:
            0
        case .tertiary:
            1
        case .clear:
            0
        case .paymentMethod:
            1
        case .picker:
            2
        }
    }
}

enum PrimaryButtonSize {
    case xsmall
    case small
    case medium
    case large
    case paymentMethod
    case picker

    var padding: EdgeInsets {
        switch self {
        case .xsmall:
            EdgeInsets(top: 8, leading: 32, bottom: 8, trailing: 32)
        case .small:
            EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        case .medium:
            EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        case .large:
            EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
        case .paymentMethod:
            EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
        case .picker:
            EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        }
    }

    var textFont: UIFont {
        switch self {
        case .xsmall:
            .buttonSmall
        case .small:
            .buttonSmall
        case .medium:
            .buttonMedium
        case .large:
            .buttonXLarge
        case .paymentMethod:
            .labelLarge
        case .picker:
            .buttonXLarge
        }
    }

    var cornerRadius: CGFloat {
        .infinity
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    @EnvironmentObject private var colorManager: ColorManager
    let type: PrimaryButtonType
    let size: PrimaryButtonSize
    var isEnabled = true
    var isLoading = false
    var isExpanded: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            HStack {
                configuration.label
                    .foregroundColor(textColor)
                    .customScaledFont(size.textFont)
                    .frame(maxWidth: isExpanded ? .infinity : nil)
            }
            .opacity(isLoading ? 0 : 1)

            if isLoading {
                LoaderView(
                    size: .small,
                    trackColor: Color.clear,
                    spinnerColor: typeTextColor
                )
            }
        }
        .padding(size.padding)
        .frame(minHeight: height)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
        )
        .background(
            backgroundColor(isPressed: configuration.isPressed),
            in: RoundedRectangle(cornerRadius: cornerRadius)
        )
        .contentShape(Rectangle())
        .allowsHitTesting(isEnabled && !isLoading)
    }
}

private extension PrimaryButtonStyle {
    var typeTextColor: Color {
        switch type {
        case .primary:
            DesignConfig.default.textColor.dark
        case .tertiary:
            colorManager.brandColor
        case .clear:
            colorManager.textColor
        case .paymentMethod, .picker:
            colorManager.textColor
        }
    }

    var typeInactiveTextColor: Color {
        switch type {
        case .primary:
            DesignConfig.default.textColor.dark.opacity(0.6)
        case .tertiary:
            colorManager.brandDisabledColor
        case .clear:
            colorManager.textColor
        case .paymentMethod, .picker:
            colorManager.textColor
        }
    }

    var typeBackgroundColor: Color {
        switch type {
        case .primary:
            colorManager.brandColor
        case .tertiary, .picker:
            Color.clear
        case .clear:
            Color.clear
        case .paymentMethod:
            colorManager.contentColor
        }
    }

    var typePressedBackgroundColor: Color {
        switch type {
        case .primary:
            colorManager.brandDisabledColor
        case .tertiary, .picker:
            Color.clear
        case .clear:
            Color.clear
        case .paymentMethod:
            colorManager.contentDisabledColor
        }
    }

    var typeDisabledBackgroundColor: Color {
        switch type {
        case .primary:
            colorManager.brandDisabledColor
        case .tertiary:
            Color.clear
        case .clear, .picker:
            Color.clear
        case .paymentMethod:
            colorManager.contentColor
        }
    }

    var typeBorderColor: Color {
        switch type {
        case .primary:
            Color.clear
        case .tertiary:
            colorManager.brandColor
        case .clear, .picker:
            Color.clear
        case .paymentMethod:
            Colors.neutral400
        }
    }

    var typeInactiveBorderColor: Color {
        switch type {
        case .primary:
            Color.clear
        case .tertiary:
            colorManager.brandDisabledColor
        case .clear, .picker:
            Color.clear
        case .paymentMethod:
            Colors.neutral500
        }
    }
}

private extension PrimaryButtonStyle {
    var textColor: Color {
        isEnabled ? typeTextColor : typeInactiveTextColor
    }

    var borderColor: Color {
        isEnabled ? typeBorderColor : typeInactiveBorderColor
    }

    var cornerRadius: CGFloat {
        switch size {
        case .xsmall, .small, .medium, .large, .picker:
            size.cornerRadius
        case .paymentMethod:
            isEnabled ? size.cornerRadius : 16
        }
    }

    var borderWidth: CGFloat {
        switch size {
        case .xsmall, .small, .medium, .large:
            type.borderWidth
        case .picker:
            isEnabled ? type.borderWidth : 0
        case .paymentMethod:
            isEnabled ? type.borderWidth : 0
        }
    }

    var height: CGFloat {
        switch size {
        case .xsmall, .small, .medium, .large, .picker:
            48
        case .paymentMethod:
            isEnabled ? 48 : 56
        }
    }

    func backgroundColor(isPressed: Bool) -> Color {
        guard isEnabled else {
            return typeDisabledBackgroundColor
        }

        return isPressed ? typePressedBackgroundColor : typeBackgroundColor
    }
}
