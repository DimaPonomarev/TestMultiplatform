//
//  Routes.swift
//  LoginModule
//
//  Created by Дмитрий Пономарев on 07.02.2025.
//

import Foundation
import Infrastructure
import SwiftUI
import HomeModule
import LoginModule

extension Router {
    @ViewBuilder
    func destanation(for route: Route) -> some View {
        switch route {
        case .description:
            MainView()
        case .login:
            LoginView()
        case .home:
            HomeView()
        @unknown default:
            fatalError("No screen")
        }
    }
}
