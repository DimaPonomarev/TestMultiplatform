//
//  LoginScreen.swift
//  iosApp
//
//  Created by Aleksey Mikhailov on 30.04.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MultiPlatformLibrary
import mokoMvvmFlowSwiftUI
import Combine

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    @State private var isSuccessfulAlertShowed: Bool = false
    @State private var navigateToHomeScreen = false
    
    var body: some View {
        NavigationStack {
            Group {
                VStack(spacing: 8.0) {
                    TextField(MR.strings().login.desc().localized(), text: viewModel.binding(\.login))
                        .textFieldStyle(.roundedBorder)
                        .disabled(viewModel.state(\.isLoading))
                    
                    SecureField(MR.strings().password.desc().localized(), text: viewModel.binding(\.password))
                        .textFieldStyle(.roundedBorder)
                        .disabled(viewModel.state(\.isLoading))
                    
                    Button(
                        action: {
                            viewModel.onLoginPressed()
                        }, label: {
                            if viewModel.state(\.isLoading) {
                                ProgressView()
                            } else {
                                Text(MR.strings().log_in.desc().localized())
                            }
                        }
                    ).disabled(!viewModel.state(\.isButtonEnabled))
                }.padding()
            }
            .navigationDestination(
                isPresented: $navigateToHomeScreen,
                destination: { HomeView() }
            )
            .alert(
                "Login successful",
                isPresented: $isSuccessfulAlertShowed
            ) {
                HStack {
                    Button(MR.strings().button_no.desc().localized()) {
                        viewModel.hideAlert()
                    }
                    
                    Button(MR.strings().button_yes.desc().localized()) {
                        viewModel.onShowNextScreen()
                        
                    }
                }
            }
            .task {
                for await value in viewModel._isAlertShown {
                    isSuccessfulAlertShowed = value.boolValue
                }
            }
        }
        .onReceive(createPublisher(viewModel.actions)) { action in
            switch onEnum(of: action) {
            case .showNext(let asocVal):
                navigateToHomeScreen = true
            }
        }
    }
    
    func tezt() {
        
    }
    
    func test1() {
        
    }
    
    func new () {
        
    }
    
    func new1() {
        
    }
    
    func test2() {
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
