//
//  ContentView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI

struct ContentView: View {
    let keychainService = KeychainService()
    var body: some View {
        CardListView(keychainService: keychainService)
    }
}


#Preview {
    ContentView()
}
