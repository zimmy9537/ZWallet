//
//  ContentView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = true

    var body: some View {
        if isUnlocked {
            let keychainService = KeychainService()
            CardListView(keychainService: keychainService)
        } else {
            AuthenticationView(isUnlocked: $isUnlocked)
        }
    }
}


struct AuthenticationView: View {
    @Binding var isUnlocked: Bool
    @State private var isAuthenticationError = false

    var body: some View {
        VStack {
            Text("Unlock ZWallet")
                .font(.largeTitle)
                .padding()

            Button("Authenticate with Face ID/Touch ID") {
                authenticate()
            }
            .padding()

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

    private func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access ZWallet"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
