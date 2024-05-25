//
//  AuthenticationView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 21/05/24.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView<Content>: View where Content: View {
    @Binding var isUnlocked: Bool // Binding to track authentication status
    @State private var isAuthenticationError = false
    var content: () -> Content // Closure returning the view to navigate to after authentication

    var body: some View {
        VStack {
            if isUnlocked {
                // Show content if already unlocked
                content()
            } else {
                VStack {
                    Text("Unlock ZWallet")
                        .font(.largeTitle)
                        .padding()
                    Text("Authenticate with Face ID/Touch ID")
                        .font(.subheadline)
                        .padding()
                    Text("Authenticate")
                        .onTapGesture {
                            authenticate()
                        }
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                .alert(isPresented: $isAuthenticationError) {
                    Alert(
                        title: Text("Authentication Error"),
                        message: Text("Biometric authentication failed."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
        .onAppear {
            authenticate()
        }
    }

    private func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access ZWallet"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true // Update the binding upon successful authentication
                    } else {
                        isAuthenticationError = true
                    }
                }
            }
        } else {
            isAuthenticationError = true
        }
    }
}
