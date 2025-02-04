//
//  LoginScreen.swift
//  iosApp
//
//  Created by Aleksey Mikhailov on 30.04.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MultiPlatformLibrary
import Combine
import Infrastructure

struct LoginView: View {
    @StateObject var viewModel = KMPLoginViewModel()
        
    var body: some View {
        NavigationStack {
            Group {
                VStack(spacing: 8.0) {
                    TextField(MR.strings().login.desc().localized(), text: $viewModel.login)
                        .textFieldStyle(.roundedBorder)
                        .disabled(viewModel.isLoading)
                    
                    SecureField(MR.strings().password.desc().localized(), text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                        .disabled(viewModel.isLoading)
                    
                    Button(
                        action: {
                            viewModel.instance.onLoginPressed()
                        }, label: {
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                Text(MR.strings().log_in.desc().localized())
                            }
                        }
                    ).disabled(!viewModel.isButtonEnabled)
                }.padding()
            }
            .navigationDestination(
                isPresented: $viewModel.navigateToHomeScreen,
                destination: { HomeView() }
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

@MainActor
final class KMPLoginViewModel: ViewModelRoot {
    private(set) var instance: LoginViewModel = LoginViewModel()
    
    @Published var login: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isButtonEnabled: Bool = false
    @Published var isAlertShown: Bool = false
    @Published var navigateToHomeScreen: Bool = false
    
    override init() {
        super.init()
        bindValues()
    }
    
    override func bindValues() {
        instance.login.subscribe(to: asyncSubscribers) { value in
            self.login = value
        }
        instance.password.subscribe(to: asyncSubscribers) { value in
            self.password = value
        }
        instance.isLoading.subscribe(to: asyncSubscribers) { value in
            self.isLoading = value.boolValue
        }
        instance.isButtonEnabled.subscribe(to: asyncSubscribers) { value in
            self.isButtonEnabled = value.boolValue
        }
        instance.isAlertShown.subscribe(to: asyncSubscribers) { value in
            self.isAlertShown = value.boolValue
        }
        instance.actions.subscribe(to: asyncSubscribers) { [weak self] action in
            switch onEnum(of: action) {
            case .showNext(let value): self?.navigateToHomeScreen = true
            }
        }
    }
}


struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
