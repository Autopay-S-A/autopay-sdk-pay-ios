//
//  DemoAutopaySdkApp.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import SwiftUI

@main
struct DemoAutopaySdkApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var colorManager: ColorManager = .init()

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.clear]

        UINavigationBar.appearance().standardAppearance = appearance

        if #unavailable(iOS 17) {
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environmentObject(colorManager)
        }
    }
}
