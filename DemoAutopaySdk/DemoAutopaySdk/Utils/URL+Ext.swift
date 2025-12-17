//
//  URL+Ext.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import Foundation

extension URL: @retroactive Identifiable {
    public var id: String { absoluteString }
}
