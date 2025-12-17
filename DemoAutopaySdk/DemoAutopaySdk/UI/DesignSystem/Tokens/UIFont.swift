//
//  UIFont.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

extension UIFont {
    static var pXSmall = getFont(weight: .regular, size: 12)
    static var labelSmall = getFont(weight: .medium, size: 12)
    static var labelMedium = getFont(weight: .regular, size: 14)
    static var labelLarge = getFont(weight: .regular, size: 16)
    static var labelXLarge = getFont(weight: .regular, size: 18)
    static var pSmall = getFont(weight: .regular, size: 14)
    static var buttonSmall = getFont(weight: .regular, size: 12)
    static var buttonMedium = getFont(weight: .regular, size: 14)
    static var buttonLarge = getFont(weight: .regular, size: 16)
    static var buttonXLarge = getFont(weight: .regular, size: 18)
    static var inputLarge = getFont(weight: .regular, size: 16)

    private static func getFont(weight: UIFont.Weight, size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: weight)
    }
}
