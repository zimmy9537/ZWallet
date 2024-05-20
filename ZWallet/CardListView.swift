//
//  CardListView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI

struct Card: Codable, Identifiable {
    var id = UUID()
    var number: String
    var holder: String
    var expiration: String
}

struct CardListView: View {
    @State private var cards: [Card] = []
    let keychainService: KeychainService

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) { // Use LazyVStack to allow dynamic content height
                    ForEach(cards) { card in
                        CardView(card: card)
                            .padding(.horizontal)
                            .padding(.top, 10)
                            .frame(maxWidth: .infinity) // Allow CardView to take full width
                    }
                }
                .padding()
            }
            .navigationTitle("My Cards")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddCardView(keychainService: keychainService)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                cards = keychainService.loadCards()
            }
        }
    }
}


struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock KeychainService instance for preview
        let keychainService = KeychainService()
        return CardListView(keychainService: keychainService)
    }
}
