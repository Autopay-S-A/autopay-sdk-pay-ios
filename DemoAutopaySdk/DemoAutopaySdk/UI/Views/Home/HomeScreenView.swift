//
//  HomeScreenView.swift
//  DemoAutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//

import AutopaySdk
import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject private var colorManager: ColorManager
    @ObservedObject private var sdkConfigManager = SdkConfigManager.shared
    @ObservedObject private var viewModel = HomeScreenViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                colorManager.neutralLightColor.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 12) {
                        paymentFormView
                        themeView
                        serviceView
                        if sdkConfigManager.param(for: .method) == PaymentFormType.native.rawValue {
                            nextButton
                        } else {
                            webViewNextButton
                        }
                        VersionView()
                    }.padding(16)
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        PaymentContentView(viewType: .cardActivation)
                    } label: {
                        Image("card_activation")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(colorManager.textColor)
                            .frame(width: 24, height: 24)
                    }
                    .accessibilityLabel("demo_card_autopayment_button")
                }
                ToolbarItem(placement: .topBarLeading) {
                    HStack(alignment: .lastTextBaseline, spacing: 6) {
                        Image("logo_autopay")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                            .padding(.bottom, 4)
                        Image("logo_autopay_text")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(colorManager.textColor)
                            .frame(height: 24)
                        Image("logo_autopay_text_sdk")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(colorManager.textColor)
                            .frame(height: 10)
                            .padding(.bottom, 4)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("demo_logo_autopay")
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(
                isPresented: $viewModel.shouldShowPaymentStatus,
                content: {
                    if let viewModel = viewModel.paymentStatusViewModel {
                        PaymentStatusView(viewModel: viewModel, isPresented: $viewModel.shouldShowPaymentStatus) {}
                    }
                }
            )
        }
        .navigationViewStyle(.stack)
        .accentColor(colorManager.brandColor)
    }

    private var paymentFormView: some View {
        VStack(spacing: 16) {
            Text("demo_home_active_form")
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityAddTraits(.isHeader)
            CurrentPaymentFormTypeView()
            NavigationLink {
                PaymentFormPickupView()
            } label: {
                Text("demo_common_change")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(PrimaryButtonStyle(type: .tertiary, size: .large))
        }.boxStyle()
    }

    private var themeView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("demo_home_theme")
                .customScaledFont(.labelLarge)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("demo_home_theme_selected_color")
                    .customScaledFont(.labelMedium)
                HStack(spacing: 6) {
                    colorManager.brandColor
                        .cornerRadius(4)
                        .frame(width: 18, height: 18)
                    Text(colorManager.brandColor.toHex() ?? "")
                        .customScaledFont(.labelMedium)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5.5)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(colorManager.neutralLightColor)
                )
            }
            .accessibilityElement(children: .combine)
            NavigationLink {
                ThemeView()
            } label: {
                HStack(alignment: .center) {
                    Image("edit_icon")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(colorManager.brandColor)
                        .frame(width: 16, height: 16)
                    Text("demo_common_edit")
                        .foregroundColor(colorManager.brandColor)
                        .customScaledFont(.buttonLarge)

                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(alignment: .leading)

        }.boxStyle()
    }

    private var serviceView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("demo_home_service")
                .customScaledFont(.labelLarge)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("demo_home_service_selected")
                    .customScaledFont(.labelMedium)
                Group {
                    Text(LocalizedStringKey(
                        EnvironmentConfigType(rawValue: SdkConfigManager.shared.param(for: .environment))?.titleKey ?? ""
                    ))
                    .customScaledFont(.labelMedium)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5.5)
                }
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(colorManager.neutralLightColor)
                )
            }
            .accessibilityElement(children: .combine)
            NavigationLink {
                ServiceConfigView(viewModel: ServiceConfigViewModel(sdkConfigManager: SdkConfigManager.shared))
            } label: {
                HStack(alignment: .center) {
                    Image("edit_icon")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(colorManager.brandColor)
                        .frame(width: 16, height: 16)
                    Text("demo_common_edit")
                        .foregroundColor(colorManager.brandColor)
                        .customScaledFont(.buttonLarge)

                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(alignment: .leading)

        }.boxStyle()
    }

    @ViewBuilder
    private var nextButton: some View {
        if viewModel.isLoading {
            LoaderView(size: .small, trackColor: Color.white, spinnerColor: colorManager.brandDisabledColor)
        } else {
            NavigationLink {
                PaymentContentView(viewType: .payment)
            } label: {
                Text("demo_common_next")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(PrimaryButtonStyle(
                type: .primary,
                size: .large,
                isEnabled: viewModel.isLoading == false
            ))
        }
    }

    private var webViewNextButton: some View {
        NavigationLink {
            WebMethodView(viewModel: .init(transactionCallback: { orderId, result, error in
                viewModel.webMethodDidEnd(orderId: orderId, result: result, error: error)
            }))
        } label: {
            Text("demo_common_next")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(PrimaryButtonStyle(
            type: .primary,
            size: .large,
            isEnabled: viewModel.isLoading == false
        ))
    }
}

#Preview {
    HomeScreenView()
}
