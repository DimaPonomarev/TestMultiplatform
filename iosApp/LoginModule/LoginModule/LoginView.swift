//
//  LoginView.swift
//  LoginModule
//
//  Created by Дмитрий Пономарев on 06.02.2025.
//

import SwiftUI
import Infrastructure
import CommonUI

import SwiftUI
import Infrastructure
import CommonUI

public struct LoginView: View {
    @StateObject var viewModel = KMPLoginViewModel()

    public init() {}

    public var body: some View {
        NavigationStack {
            Group {
                LazyVStack(spacing: 8.0) {
                    CustomTextField(
                        isDisabled: $viewModel.isLoading,
                        text: $viewModel.login,
                        placeHolder: MR.strings().login.desc().localized()
                    )
                    CustomSecureField(
                        isDisabled: $viewModel.isLoading,
                        text: $viewModel.password,
                        placeHolder: MR.strings().password.desc().localized()
                    )
                    CustomButton(
                        action: { viewModel.instance.onLoginPressed() },
                        isDisabled: $viewModel.isButtonEnabled,
                        content: {
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                Text(MR.strings().log_in.desc().localized())
                            }
                        })

                }
                .padding()
                .frame(maxHeight: .infinity)
                .background(Color.gray)
            }
            .navigationDestination(
                isPresented: $viewModel.navigateToHomeScreen,
                destination: { Text("lolo") }
            )
            .onChange(of: viewModel.login) { value in
                viewModel.instance.setLogin(value: value)
            }
            .onChange(of: viewModel.password) { value in
                viewModel.instance.setPassword(value: value)
            }
            .alert(
                "Login successful",
                isPresented: $viewModel.isAlertShown
            ) {
                HStack {
                    Button(MR.strings().button_no.desc().localized()) {
                        viewModel.instance.hideAlert()
                    }

                    Button(MR.strings().button_yes.desc().localized()) {
                        viewModel.instance.onShowNextScreen()

                    }
                }
            }
        }
    }
}


struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
