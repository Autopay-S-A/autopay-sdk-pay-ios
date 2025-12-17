//
//  LoaderView.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

struct LoaderView: View {
    @State private var isAnimating = false

    let size: LoaderSize
    let trackColor: Color
    let spinnerColor: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(trackColor, lineWidth: size.lineWidth)
            Circle()
                .trim(from: 0.0, to: 0.2)
                .stroke(
                    spinnerColor,
                    style: StrokeStyle(
                        lineWidth: size.lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .frame(width: size.size, height: size.size)
        .onAppear {
            isAnimating = true
        }
    }
}
