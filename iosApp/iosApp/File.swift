//
//  File.swift
//  Infrastructure
//
//  Created by Дмитрий Пономарев on 02.02.2025.
//
//
//import Foundation
//
//
//import Combine
//
//@MainActor
//open class ViewModelRoot: ObservableObject {
//    public let asyncSubscribers = AsyncSequenceSubscribers()
//    
//    public init() {}
//    
//    deinit {
//        print("\(self) deinit")
//        asyncSubscribers.unsubsribeAll()
//    }
//    
//    open func bindValues() {}
//}
//
//public extension SkieSwiftMutableStateFlow<ViewModelState> {
//    @MainActor
//    func subscribeState() {
//        let asyncSubscribers = AsyncSequenceSubscribers()
//        self.subscribe(to: asyncSubscribers) { state in
//            print("CURRENT STATE: \(state)")
//            switch onEnum(of: state) {
//            case .error(let error):
//                StateManager.shared.setLoading(loading: false)
//                StateManager.shared.setError(
//                    showError: true,
//                    errorMessage: error.message ?? ""
//                )
//                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                    StateManager.shared.setError(
//                        showError: false,
//                        errorMessage: ""
//                    )
//                }
//            case .idle(_):
//                StateManager.shared.setLoading(loading: false)
//            case .loading(_):
//                StateManager.shared.setLoading(loading: true)
//            }
//        }
//    }
//}
