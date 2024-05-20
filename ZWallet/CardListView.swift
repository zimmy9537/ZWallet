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
                                .contextMenu {
                                    Button(action: {
                                        cardToDelete = card
                                        showingDeleteConfirmation = true
                                    }) {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
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
                .alert(isPresented: $showingDeleteConfirmation) {
                    Alert(
                        title: Text("Delete Card"),
                        message: Text("Are you sure you want to delete this card?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let cardToDelete = cardToDelete {
                                deleteCard(cardToDelete)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
    
    private func deleteCard(_ card: Card) {
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                cards.remove(at: index)
                keychainService.deleteCard(card: card)
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
