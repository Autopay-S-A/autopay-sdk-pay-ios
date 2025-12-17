//
//  ViewState.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case error(ErrorState)
    case content
}
