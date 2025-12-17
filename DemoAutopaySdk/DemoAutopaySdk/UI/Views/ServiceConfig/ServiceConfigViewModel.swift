//
//  ServiceConfigViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

class ServiceConfigViewModel: ObservableObject {
    @Published var serviceEnvironment: EnvironmentConfigType = .production
    var paramValues = [String: String]()

    private let sdkConfigManager: SdkConfigManager

    init(sdkConfigManager: SdkConfigManager) {
        self.sdkConfigManager = sdkConfigManager

        serviceEnvironment = EnvironmentConfigType(rawValue: sdkConfigManager.param(for: .environment)) ?? .development
        paramValues = sdkConfigManager.allParamsAsDictionary
    }

    func save() {
        paramValues[ServiceConfigType.environment.rawValue] = serviceEnvironment.rawValue
        sdkConfigManager.save(paramValues: paramValues)
    }
}
