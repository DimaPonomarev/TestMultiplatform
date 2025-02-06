import SwiftUI
//import mokoMvvmFlowSwiftUI
//import MultiPlatformLibrary

import MainModule
import Infrastructure

@main
struct iOSApp: App {
    
    @StateObject private var router: Router = Router.shared

    var body: some Scene {
		WindowGroup {
            Group {
                MainView()
                    .environmentObject(router)
            }
		}
	}
}






//
//
//
