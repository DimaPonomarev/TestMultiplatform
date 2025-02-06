//
//  LoginView.swift
//  LoginModule
//
//  Created by Дмитрий Пономарев on 06.02.2025.
//

import SwiftUI
import Infrastructure
import CommonUI
import HomeModule

public struct LoginView: View {
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.routes) {
            NavigationStack(path: $router.routes) {
                Group {
                    router.destanation(for: router.mainRoute)
                }
                .navigationDestination(for: Route.self, destination: { route in
                    router.destanation(for: route)
                })
            }
        }
    }
}
    
    
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
    
    
    
    
    
extension Router {
    @ViewBuilder
    func destanation(for route: Route) -> some View {
        switch route {
        case .login:
            LoginView()
        case .main:
            MainView()
        case .home:
            HomeView()
            
        @unknown default:
            fatalError("No screen")
        }
    }
}
    
    
    
    
    
struct MainView: View {
    
    @StateObject var viewModel = KMPLoginViewModel()
    
    var body: some View {
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
