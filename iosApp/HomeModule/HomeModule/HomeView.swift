//
//  HomeView.swift
//  HomeModule
//
//  Created by Дмитрий Пономарев on 06.02.2025.
//

import SwiftUI
import CommonUI
import Infrastructure

public struct HomeView: View {
//    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel = KMPHomeViewModel()

    @State private var isSuccessfulAlertShowed: Bool = false

    public init() {}
    
    public var body: some View {
        Group {
            VStack(spacing: 8.0) {
                TextField("Login", text: .constant("lp"))
                    .textFieldStyle(.roundedBorder)

//                Button(
//                    action: {
//                        viewModel.instance.goBack()
//                    }, label: {
//                        if viewModel.isLoading {
//                            ProgressView()
//                        } else {
//                            Text("Login")
//                        }
//                    }
//                )
            }
            .padding()
        }
    }
}


@MainActor
final class KMPHomeViewModel: ViewModelRoot {
    private(set) var instance: HomeViewModel = HomeViewModel()

//    @Published var login: String = ""
//    @Published var isLoading: Bool = false


//    override init() {
//        super.init()
//        bindValues()
//    }

//    override func bindValues() {
//        instance.login.subscribe(to: asyncSubscribers) { value in
//            self.login = value
//        }
//        instance.isLoading.subscribe(to: asyncSubscribers) { value in
//            self.isLoading = value.boolValue
//        }

//        instance.actions.subscribe(to: asyncSubscribers) { [weak self] action in
//            switch onEnum(of: action) {
//            case .showNext(let value): self?.navigateToHomeScreen = true
//            }
//        }
//    }
}
