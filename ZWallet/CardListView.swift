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
    var bankName: String
    var pin: String
    var isDebitCard: Bool
}

struct CardListView: View {
    @State private var cards: [Card] = []
    let keychainService: KeychainService

    @State private var showingDeleteConfirmation = false
    @State private var cardToDelete: Card? // Track card for deletion confirmation

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .center) {
                    ForEach(cards) { card in
                        NavigationLink(destination: DetailCardView(card: card)) {
                            CardView(card: card, showMaskedNumber: true)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .frame(height: 250)
                        }
                    }
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
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock KeychainService instance for preview
        let keychainService = KeychainService()
        return CardListView(keychainService: keychainService)
    }
}
