//
//  EnvironmentConfigTypeView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct EnvironmentConfigTypeView: View {
    @EnvironmentObject private var colorManager: ColorManager
    var type: EnvironmentConfigType
    @Binding var selectedType: EnvironmentConfigType

    var body: some View {
        ZStack {
            Text(LocalizedStringKey(type.titleKey))
                .customScaledFont(.labelXLarge)
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(colorManager.brandColor, lineWidth: selectedType == type ? 2 : 0)
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(colorManager.backgroundColor)
        ).overlay {
            if selectedType == type {
                HStack(alignment: .top) {
                    Spacer()
                    VStack(alignment: .center) {
                        Image("selected_icon")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(colorManager.brandColor)
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 24)
                            .accessibilityHidden(true)
                    }
                }
            }
        }.onTapGesture {
            selectedType = type
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityAddTraits(selectedType == type ? .isSelected : .isButton)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    EnvironmentConfigTypeView(type: .production, selectedType: .constant(.production))
}
