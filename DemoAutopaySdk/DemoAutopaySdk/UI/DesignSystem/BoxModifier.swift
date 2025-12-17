//
//  BoxModifier.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct BoxModifier: ViewModifier {
    @EnvironmentObject private var colorManager: ColorManager
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(colorManager.backgroundColor)
            )
    }
}

extension View {
    func boxStyle() -> some View {
        modifier(BoxModifier())
    }
}
