//
//  ErrorView.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    let state: ErrorState

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center, spacing: 32) {
                Image("error_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 88, height: 88)
                    .accessibilityHidden(true)
                VStack(alignment: .center, spacing: 8) {
                    Text("demo_error_title")
                        .multilineTextAlignment(.center)
                        .customScaledFont(.labelXLarge)
                    Text(state.message)
                        .multilineTextAlignment(.center)
                        .customScaledFont(.labelLarge)
                }
            }
            Spacer(minLength: 32)
            Button(action: {
                state.retry()
            }, label: {
                Text("demo_common_retry")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(PrimaryButtonStyle(type: .primary,
                                            size: .large))
        }
        .padding(16)
    }
}
