//
//  PaymentStatusView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct PaymentStatusView: View {
    @EnvironmentObject private var colorManager: ColorManager
    @StateObject var viewModel: PaymentStatusViewModel
    @Binding var isPresented: Bool
    var onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center, spacing: 32) {
                Image(viewModel.status.imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(imageColor)
                    .frame(width: 88, height: 88)
                    .accessibilityHidden(true)
                Text(LocalizedStringKey(viewModel.status.titleKey))
                    .multilineTextAlignment(.center)
                    .customScaledFont(.labelLarge)
                    .accessibilityAddTraits(.updatesFrequently)
            }
            Spacer()
            Button(action: {
                isPresented = false
            }, label: {
                Text("demo_common_ok")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(PrimaryButtonStyle(type: .primary,
                                            size: .large))
        }
        .padding(16)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.startTask()
        }
        .onDisappear { onDismiss() }
    }
    
    private var imageColor: Color {
        switch viewModel.status {
        case .success:
            colorManager.brandColor
        case .failure:
            colorManager.errorColor
        default:
            colorManager.neutralDarkColor
        }
    }
}
