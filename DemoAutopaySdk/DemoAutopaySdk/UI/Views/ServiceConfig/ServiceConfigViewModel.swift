//
//  ServiceConfigViewModel.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

class ServiceConfigViewModel: ObservableObject {
    @Published var serviceEnvironment: EnvironmentConfigType = .production
    @Published var paramValues = [String: String]()

    private let sdkConfigManager: SdkConfigManager
    
    var saveButtonEnabled: Bool {
        ServiceConfigType.editable.allSatisfy({ isValid($0) })
    }

    init(sdkConfigManager: SdkConfigManager) {
        self.sdkConfigManager = sdkConfigManager

        serviceEnvironment = EnvironmentConfigType(rawValue: sdkConfigManager.param(for: .environment)) ?? .development
        paramValues = sdkConfigManager.allParamsAsDictionary
    }

    func save() {
        paramValues[ServiceConfigType.environment.rawValue] = serviceEnvironment.rawValue
        sdkConfigManager.save(paramValues: paramValues)
    }
    
    private func isValid(_ type: ServiceConfigType) -> Bool {
        guard type.isRequired else {
            return true
        }
        guard let value = paramValues[type.rawValue] else {
            return false
        }
        switch type {
        case .price:
            return Double(value.replacingOccurrences(of: ",", with: ".")) != nil
        case .contextPath:
            return value.first == "/"
        default:
            return !value.isEmpty
        }
    }
}
