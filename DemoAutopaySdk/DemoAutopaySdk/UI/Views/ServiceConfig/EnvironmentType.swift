//
//  EnvironmentType.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import Foundation

enum EnvironmentConfigType: String, CaseIterable {
    case production
    case development

    var titleKey: String {
        "demo_home_service_\(self)"
    }
}
