//
//  ServiceConfigView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct ServiceConfigView: View {
    @EnvironmentObject private var colorManager: ColorManager
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ServiceConfigViewModel

    var body: some View {
        ZStack {
            colorManager.neutralLightColor
                .ignoresSafeArea()
            VStack(spacing: 12) {
                ScrollView {
                    VStack(spacing: 24) {
                        enviromentSection
                        configSection
                    }
                    .padding(16)
                }
                saveButton
                    .padding([.leading, .trailing], 16)
                VersionView()
                    .padding([.leading, .trailing, .bottom], 16)
            }
        }.navigationTitle("demo_home_service")
    }

    private var enviromentSection: some View {
        VStack(spacing: 20) {
            VStack(spacing: 12) {
                Text("demo_config_subtitle")
                    .customScaledFont(.labelXLarge)
                    .multilineTextAlignment(.center)
                Text("demo_config_content")
                    .customScaledFont(.pSmall)
                    .multilineTextAlignment(.center)
            }
            VStack(spacing: 16) {
                ForEach(EnvironmentConfigType.allCases, id: \.self) { type in
                    EnvironmentConfigTypeView(type: type, selectedType: $viewModel.serviceEnvironment)
                }
            }
        }
    }

    private var configSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("demo_service_config_section_title")
                .customScaledFont(.labelXLarge)
            VStack(spacing: 16) {
                ForEach(ServiceConfigType.editable, id: \.self) { type in
                    switch type.viewType {
                    case .textField:
                        TextFieldServiceConfigView(
                            type: type,
                            value: Binding(get: {
                                viewModel.paramValues[type.rawValue] ?? ""
                            }, set: { value in
                                viewModel.paramValues[type.rawValue] = value
                            })
                        )
                    case .toggle:
                        Toggle(isOn: Binding(get: {
                            let value = viewModel.paramValues[type.rawValue] ?? ""
                            return Bool(value) ?? false
                        }, set: { value in
                            viewModel.paramValues[type.rawValue] = "\(value)"
                        })) {
                            Text(LocalizedStringKey(type.titleKey))
                        }.toggleStyle(PrimaryToggleStyle())
                    }
                }
            }
        }
    }

    private var saveButton: some View {
        Button(action: {
            viewModel.save()
            dismiss()
        }, label: {
            Text("demo_common_save")
        })
        .buttonStyle(PrimaryButtonStyle(type: .primary,
                                        size: .large,
                                        isEnabled: viewModel.saveButtonEnabled))
    }
}

// #Preview {
//    ServiceConfigView()
// }
