//
//  CardViewModel.swift
//  ZWallet
//
//  Created by Zimmy Changela on 31/05/24.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    private let keyChainService : KeychainService
    	
    init(keyChainService: KeychainService) {
        self.keyChainService = keyChainService
        loadCards()
    }
    
    func loadCards() {
        cards = keyChainService.loadCards()
    }
    
    func addCards(_ card: Card) {
        cards.append(card)
        keyChainService.saveCard(card: card)
        objectWillChange.send()
    }
    
    func deleteCard(_ card : Card){
        if let index = cards.firstIndex(where: {$0.id == card.id}) {
            cards.remove(at: index)
            keyChainService.deleteCard(card: card)
            objectWillChange.send()
        }
    }
}
