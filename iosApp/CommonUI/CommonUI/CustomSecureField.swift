//
//  SwiftUIView.swift
//  CommonUI
//
//  Created by Дмитрий Пономарев on 05.02.2025.
//

import SwiftUI

public struct CustomSecureField: View {
    @Binding var isDisabled: Bool
    @Binding var text: String
    @State var placeHolder: String

    
    public init(isDisabled: Binding<Bool>, text: Binding<String>, placeHolder: String) {
        self._isDisabled = isDisabled
        self._text = text
        self.placeHolder = placeHolder
    }
    
    public var body: some View {
        SecureField(placeHolder, text: $text)
            .textFieldStyle(.roundedBorder)
            .disabled(isDisabled)
    }
}

//#Preview {
//    SwiftUIView()
//}
