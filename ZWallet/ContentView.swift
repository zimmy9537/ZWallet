//
//  ContentView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI
struct ContentView: View {
    @State private var isUnlocked = true
    var body: some View {
        let keychainService = KeychainService()
        CardListView(keychainService: keychainService)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
