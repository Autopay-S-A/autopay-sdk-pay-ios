//
//  LoaderSize.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import Foundation

enum LoaderSize {
    case small
    case large

    var size: CGFloat {
        switch self {
        case .small:
            24
        case .large:
            60
        }
    }

    var lineWidth: CGFloat {
        switch self {
        case .small:
            3
        case .large:
            6
        }
    }
}
