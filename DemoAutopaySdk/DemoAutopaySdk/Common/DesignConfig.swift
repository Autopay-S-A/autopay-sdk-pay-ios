//
//  DesignConfig.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI
import AutopaySdk

struct DesignConfig {
    static let `default` = Self(
        brandColor: APColor(
            light: Color(hex: "#2E72BF"),
            dark: Color(hex: "#158EE6")
        ),
        contentColor: APColor(
            light: Color(hex: "#FFFFFF"),
            dark: Color(hex: "#0F0F0F")
        ),
        neutralLightColor: APColor(
            light: Color(hex: "#F5F5F5"),
            dark: Color(hex: "#1F1F1F")
        ),
        neutralDarkColor: APColor(
            light: Color(hex: "#808080"),
            dark: Color(hex: "#CCCCCC")
        ),
        errorColor: APColor(
            light: Color(hex: "#BF4826"),
            dark: Color(hex: "#E97655")
        ),
        backgroundColor: APColor(
            light: Color(hex: "#FFFFFF"),
            dark: Color(hex: "#0F0F0F")
        ),
        textColor: APColor(
            light: Color(hex: "#282828"),
            dark: Color(hex: "#FAFAFA")
        )
    )

    let brandColor: APColor
    let contentColor: APColor
    let neutralLightColor: APColor
    let neutralDarkColor: APColor
    let errorColor: APColor
    let backgroundColor: APColor
    let textColor: APColor
}
