//
//  MainView.swift
//  MainModule
//
//  Created by Дмитрий Пономарев on 06.02.2025.
//

import SwiftUI
import Infrastructure
import CommonUI
import LoginModule
import HomeModule

public struct MainView: View {
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
    
    
struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
    
    
    
    
    
extension Router {
    @ViewBuilder
    func destanation(for route: Route) -> some View {
        switch route {
        case .main:
            MainView()
        case .login:
            LoginViews()
        case .home:
            HomeView()
            
        @unknown default:
            fatalError("No screen")
        }
    }
}

