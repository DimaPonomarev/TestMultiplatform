//
//  Router.swift
//  Infrastructure
//
//  Created by Дмитрий Пономарев on 06.02.2025.
//

import SwiftUI
import Combine

@MainActor
public final class Router: ObservableObject {
    public static let shared = Router()
//    @Published public var rootRoute: Route = .splash
    @Published public var mainRoute: Route = .login
    @Published public var routes: [Route] = []
    @Published public var isUserAuthorized: Bool = false
    @Published public var menuXOffset: CGFloat = -400
    
    public func moveTo(_ route: Route) {
        guard route != routes.last else { return }
        routes.append(route)
        if route == .main {
            routes.removeAll { $0 != route }
        }
    }
    
    public func moveBackTo(_ route: Route) {
        guard let index = routes.firstIndex(where: { $0 == route }) else { return }
        routes.removeSubrange(index + 1...routes.count - 1)
    }}
