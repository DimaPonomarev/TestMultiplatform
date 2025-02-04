//
//  HomeView.swift
//  iosApp
//
//  Created by Дмитрий Пономарев on 11.11.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import MultiPlatformLibrary
import mokoMvvmFlowSwiftUI
import Combine

struct HomeView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    @State private var isSuccessfulAlertShowed: Bool = false
    
    var body: some View {
        Group {
            VStack(spacing: 8.0) {
                TextField("Login", text: viewModel.binding(\.login))
                    .textFieldStyle(.roundedBorder)
                    .disabled(viewModel.state(\.isLoading))
                
                Button(
                    action: {
                        viewModel.goBack()
                    }, label: {
                        if viewModel.state(\.isLoading) {
                            ProgressView()
                        } else {
                            Text("Login")
                        }
                    }
                ).disabled(!viewModel.state(\.isButtonEnabled))
            }.padding()
        }
        
        .onReceive(createPublisher(viewModel.actions)) { action in
            if let value = action as? HomeViewModelActionGoBack {
                dismiss()
            }
        }
    }
}



