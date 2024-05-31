//
//  CardListView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI	

struct CardListView: View {
    
    @ObservedObject var viewModel: CardViewModel
    @State private var cards: [Card] = []
    
    @State private var showAddCardView = false
    @State private var showBankDetailsView = false
    @State private var showingDeleteConfirmation = false
    @State private var cardToDelete: Card? // Track card for deletion confirmation

    var body: some View {
        NavigationView {
            ZStack (alignment: .bottom) {
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
                            Text("Bank Details")
                                .onTapGesture {
                                    showBankDetailsView = true
                                }
                                .foregroundColor(.blue)
                        }
                    }
                    .fullScreenCover(isPresented: $showBankDetailsView) {
                        BankDetailsListView(viewModel: .init())
                    }
                    .onAppear {
                        cards = viewModel.loadCards()
                    }
                    .alert(isPresented: $showingDeleteConfirmation) {
                        Alert(
                            title: Text("Delete Card"),
                            message: Text("Are you sure you want to delete this card?"),
                            primaryButton: .destructive(Text("Delete")) {
                                if let cardToDelete = cardToDelete {
                                    viewModel.deleteCard(cardToDelete)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                HStack {
                    Spacer()
                    NavigationLink(destination: AddCardView(viewModel: .init())) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 10)
                    }
                    .background(Color.clear)
                    .padding(.bottom, 16)
                    .padding(.trailing, 16)
                }
            }
        }
    }
    
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock KeychainService instance for preview
        return CardListView(viewModel: .init())
    }
}
