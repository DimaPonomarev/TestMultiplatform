//
//  KMPLoginViewModel.swift
//  LoginModule
//
//  Created by Дмитрий Пономарев on 06.02.2025.
//

import SwiftUI
import Infrastructure

@MainActor
final class KMPLoginViewModel: ViewModelRoot {
    private(set) var instance: LoginViewModel = LoginViewModel()

    @Published var login: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isButtonEnabled: Bool = false
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
            self.isButtonEnabled = !value.boolValue
        }
        instance.isAlertShown.subscribe(to: asyncSubscribers) { value in
            self.isAlertShown = value.boolValue
        }

        instance.actions.subscribe(to: asyncSubscribers) {  action in
            switch onEnum(of: action) {
            case .showNext(let value): Router.shared.moveTo(.home)
            }
        }
    }
}

