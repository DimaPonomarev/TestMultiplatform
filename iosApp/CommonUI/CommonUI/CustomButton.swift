//
//  CustomButton.swift
//  CommonUI
//
//  Created by Дмитрий Пономарев on 02.02.2025.
//

import SwiftUI

public struct CustomButton: View {
    var action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text("kol")
        }

    }
}

#Preview {
    CustomButton(action: {})
}
