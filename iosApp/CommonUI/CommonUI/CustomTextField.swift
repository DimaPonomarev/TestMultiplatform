//
//  CustomButton.swift
//  CommonUI
//
//  Created by Дмитрий Пономарев on 02.02.2025.
//

import SwiftUI

public struct CustomTextField: View {
    @Binding var isDisabled: Bool
    @Binding var text: String
    @State var placeHolder: String

    
    public init(isDisabled: Binding<Bool>, text: Binding<String>, placeHolder: String) {
        self._isDisabled = isDisabled
        self._text = text
        self.placeHolder = placeHolder
    }
    
    public var body: some View {
        TextField(placeHolder, text: $text)
            .textFieldStyle(.roundedBorder)
            .disabled(isDisabled)

    }
}

//#Preview {
//    CustomButton(action: {})
//}
