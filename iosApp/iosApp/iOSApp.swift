import SwiftUI
//import mokoMvvmFlowSwiftUI
//import MultiPlatformLibrary

import HomeModule
import LoginModule
import Infrastructure

@main
struct iOSApp: App {
    
    @StateObject private var router: Router = Router.shared

    var body: some Scene {
		WindowGroup {
            Group {
                LoginView()
                    .environmentObject(router)
            }
		}
	}
}






//
//
//
