//
//  PaymentFormTypeView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct PaymentFormTypeView: View {
    @EnvironmentObject private var colorManager: ColorManager
    var type: PaymentFormType
    @Binding var selectedType: PaymentFormType

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 12) {
                    Image(type.imageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(colorManager.brandColor)
                        .frame(width: 32, height: 32)
                    Text(LocalizedStringKey(type.titleKey))
                        .customScaledFont(.labelXLarge)
                    Spacer(minLength: 0)
                }
                Text(LocalizedStringKey(type.descriptionKey))
                    .customScaledFont(.pSmall)
            }
            .padding(24)
            .frame(maxWidth: .infinity)
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
                    VStack(alignment: .trailing) {
                        Image("selected_icon")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(colorManager.brandColor)
                            .frame(width: 20, height: 20)
                            .padding([.top, .trailing], 16)
                        Spacer()
                    }
                }
            }
        }.onTapGesture {
            selectedType = type
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityAddTraits(selectedType == type ? .isSelected : .isButton)
    }
}

#Preview {
    PaymentFormTypeView(type: .native, selectedType: .constant(.native))
}
