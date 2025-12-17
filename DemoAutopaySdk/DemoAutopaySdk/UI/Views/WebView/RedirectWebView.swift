//
//  RedirectWebView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct RedirectWebView: View {
    @State var url: URL?
    var transactionCallback: (APResult?, APError?) -> Void

    var body: some View {
        Group {
            if let url {
                WebView(
                    url: url,
                    transactionCallback: transactionCallback
                )
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
