//
//  CustomButton.swift
//  CommonUI
//
//  Created by Дмитрий Пономарев on 05.02.2025.
//

import SwiftUI

public struct CustomButton<Content:View>: View {
    var action: () -> Void
    @Binding var isDisabled: Bool
    var content: () -> Content
    
    public init(action: @escaping () -> Void, isDisabled: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self._isDisabled = isDisabled
        self.content = content
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            content()
        }
        .disabled(isDisabled)
    }
}

//#Preview {
//    CustomButton()
//}

