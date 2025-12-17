//
//  Colors.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

extension UIColor {
    convenience init(
        light lightModeColor: @escaping @autoclosure () -> UIColor,
        dark darkModeColor: @escaping @autoclosure () -> UIColor
    ) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                lightModeColor()
            case .dark:
                darkModeColor()
            default:
                lightModeColor()
            }
        }
    }
}

extension Color {
    init(
        light lightModeColor: @escaping @autoclosure () -> Color,
        dark darkModeColor: @escaping @autoclosure () -> Color
    ) {
        self.init(UIColor(
            light: UIColor(lightModeColor()),
            dark: UIColor(darkModeColor())
        ))
    }
}

enum Colors {
    static let neutral400 = Color(hex: "E5E5E5")
    static let neutral500 = Color(hex: "CCCCCC")
    static let neutral900 = Color(hex: "666666")
    static let shadowColor = Color(hex: "282828")
}
