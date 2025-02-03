//
//  File.swift
//  Infrastructure
//
//  Created by Дмитрий Пономарев on 02.02.2025.
//

import Foundation


import Combine

@MainActor
open class ViewModelRoot: ObservableObject {
    public let asyncSubscribers = AsyncSequenceSubscribers()
    
    public init() {}
    
    deinit {
        print("\(self) deinit")
        asyncSubscribers.unsubsribeAll()
    }
    
    open func bindValues() {}
}


