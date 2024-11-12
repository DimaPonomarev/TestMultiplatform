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
                    TextField("Login", text: viewModel.binding(\.login))
                        .textFieldStyle(.roundedBorder)
                        .disabled(viewModel.state(\.isLoading))
                    
                    SecureField("Password", text: viewModel.binding(\.password))
                        .textFieldStyle(.roundedBorder)
                        .disabled(viewModel.state(\.isLoading))
                    
                    Button(
                        action: {
                            viewModel.onLoginPressed()
                        }, label: {
                            if viewModel.state(\.isLoading) {
                                ProgressView()
                            } else {
                                Text("Login")
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
                isPresented: viewModel.binding(\.isAlertShown)
            ) {
                Button("Close", action: {
                    Task {
                        do {
                            try await viewModel.onShowNextScreen()
                        } catch {
                            print("mo")
                        }
                    }
                })
            }
        }
        .onReceive(createPublisher(viewModel.actions)) { action in
            print("ko")
            if let value = action as? LoginViewModelActionShowNext {
                
                navigateToHomeScreen = true
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
