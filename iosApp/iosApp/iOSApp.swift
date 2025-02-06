import SwiftUI
//import mokoMvvmFlowSwiftUI
//import MultiPlatformLibrary

import LoginModule
import Infrastructure

@main
struct iOSApp: App {
	var body: some Scene {
		WindowGroup {
//            Text("kol")
            LoginView()
		}
	}
}








//
////
////struct HomeView: View {
////    @Environment(\.dismiss) var dismiss
////
////    @StateObject var viewModel = KMPHomeViewModel()
////
////    @State private var isSuccessfulAlertShowed: Bool = false
////
////    var body: some View {
////        Group {
////            VStack(spacing: 8.0) {
////                TextField("Login", text: $viewModel.login)
////                    .textFieldStyle(.roundedBorder)
////
////                Button(
////                    action: {
////                        viewModel.instance.goBack()
////                    }, label: {
////                        if viewModel.isLoading {
////                            ProgressView()
////                        } else {
////                            Text("Login")
////                        }
////                    }
////                )
////            }
////            .padding()
////        }
////    }
////}
//
////
////@MainActor
////final class KMPHomeViewModel: ViewModelRoot {
////    private(set) var instance: HomeViewModel = HomeViewModel()
////
////    @Published var login: String = ""
////    @Published var isLoading: Bool = false
////
////
////    override init() {
////        super.init()
////        bindValues()
////    }
////
////    override func bindValues() {
////        instance.login.subscribe(to: asyncSubscribers) { value in
////            self.login = value
////        }
////        instance.isLoading.subscribe(to: asyncSubscribers) { value in
////            self.isLoading = value.boolValue
////        }
////
//////        instance.actions.subscribe(to: asyncSubscribers) { [weak self] action in
//////            switch onEnum(of: action) {
//////            case .showNext(let value): self?.navigateToHomeScreen = true
//////            }
//////        }
////    }
////}
//
//
//
