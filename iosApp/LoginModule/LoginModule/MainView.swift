//
//  MainView.swift
//  LoginModule
//
//  Created by Дмитрий Пономарев on 07.02.2025.
//

import SwiftUI
import Infrastructure
import CommonUI

public struct MainView: View {
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
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

#Preview {
    MainView()
}
