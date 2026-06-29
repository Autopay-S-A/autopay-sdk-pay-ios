//
//  SdkConfigManager.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import Foundation

final class SdkConfigManager: ObservableObject {
    static let shared = SdkConfigManager()

    var config: APConfig {
        APConfig(
            token: param(for: .token),
            serviceId: Int(param(for: .serviceId)) ?? 0,
            acceptorId: Int(param(for: .acceptorId)) ?? 0,
            applePayMerchantId: param(for: .applePayMerchantId),
            environment: EnvironmentConfigType(rawValue: param(for: .environment)) == .development ? .dev : .prod,
            contextPath: param(for: .contextPath),
            currencies: [param(for: .currency).uppercased()],
            useWebBlik: Bool(param(for: .useWebBlik)) ?? false
        )
    }

    var designConfig = DesignConfig.default

    @Published var allParamsAsDictionary = [String: String]()

    init() {
        load()
    }

    func load() {
        allParamsAsDictionary = loadParams()
    }

    func param(for key: ServiceConfigType) -> String {
        loadParams()[key.rawValue]!
    }

    func save(paramValues: [String: String]) {
        allParamsAsDictionary = paramValues
        UserDefaults.standard.set(paramValues, forKey: UserDefaultsKeys.sdkConfig.rawValue)
    }

    func saveParam(_ key: ServiceConfigType, _ value: String) {
        var updatedParams = allParamsAsDictionary
        updatedParams[key.rawValue] = value
        save(paramValues: updatedParams)
    }

    private let defaultConfig: [ServiceConfigType: String] = [
        .token: "eyJhY2Nlc3NfdG9rZW4iOiJmM2Y4Yzc2YS04ZDQxLTQ3ZGUtODUwNi1hOTU3MzE0Y2JjZTMiLCJ0b2tlbl90eXBlIjoibWFjIiwiZXhwaXJlc19pbiI6MzU5OSwibWFjX2tleSI6ImhmbG1zMTNNamlIYkUrRU1xYU14MUlmWnZOODFDYmM2eWN0WFk3M1U3WW89IiwibWFjX2FsZ29yaXRobSI6ImhtYWMtc2hhLTI1NiJ9",
        .serviceId: "101838",
        .acceptorId: "100573",
        .applePayMerchantId: "merchant.pl.bm.pay-accept",
        .environment: EnvironmentConfigType.development.rawValue,
        .method: PaymentFormType.native.rawValue,
        .contextPath: "/payment",
        .price: "29",
        .currency: "PLN",
        .paymentSummary: "Testowa płatność",
        .email: "devnull@bm.pl",
        .useWebBlik: "false"
    ]

    private func loadParams() -> [String: String] {
        let savedParams = UserDefaults.standard.object(forKey: UserDefaultsKeys.sdkConfig.rawValue) as? [String: String] ?? [:]
        var params = [String: String]()
        for item in ServiceConfigType.allCases {
            params[item.rawValue] = savedParams[item.rawValue] ?? defaultConfig[item] ?? ""
        }

        return params
    }
}
