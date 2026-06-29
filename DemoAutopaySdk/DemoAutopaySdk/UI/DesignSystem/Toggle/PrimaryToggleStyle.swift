//
//  PrimaryToggleStyle.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

struct PrimaryToggleStyle: ToggleStyle {
    @EnvironmentObject private var colorManager: ColorManager

    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Button(action: {
                configuration.isOn.toggle()
            }) {
                RoundedRectangle(cornerRadius: .infinity)
                    .fill(configuration.isOn ? colorManager.brandColor : colorManager.backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(configuration.isOn ? .clear : colorManager.neutralDarkColor, lineWidth: 1.2)
                            .opacity(configuration.isOn ? 0 : 1)
                            .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                    )
                    .frame(width: 43.2, height: 24)
                    .overlay(
                        Circle()
                            .fill(configuration.isOn ? colorManager.contentColor : colorManager.neutralDarkColor)
                            .padding(2.4)
                            .offset(x: configuration.isOn ? 10 : -10)
                            .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                    )
            }
            .buttonStyle(PlainButtonStyle())

            configuration.label
                .foregroundColor(colorManager.textColor)
                .customScaledFont(.inputLarge)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(minHeight: 48)
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
