//
//  VersionView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct VersionView: View {
    @EnvironmentObject private var colorManager: ColorManager

    var body: some View {
        Text(String(format: NSLocalizedString("demo_footer_ios", comment: ""), Autopay.getSdkVersion() ?? "0"))
            .foregroundColor(Colors.neutral900)
            .customScaledFont(.labelSmall)
    }
}
