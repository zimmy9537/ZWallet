//
//  KeychainService.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import KeychainAccess
import Foundation

class KeychainService {
    let keychain: Keychain

    init() {
        // Use your app's bundle identifier here
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.example.WalletApp"
        keychain = Keychain(service: bundleIdentifier)
    }

    func saveCard(card: Card) {
        do {
            let cardData = try JSONEncoder().encode(card)
            keychain[data: card.id.uuidString] = cardData
        } catch {
            print("Error saving card: \(error)")
        }
    }

    func loadCards() -> [Card] {
        return keychain.allKeys().compactMap { key in
            if let data = keychain[data: key] {
                return try? JSONDecoder().decode(Card.self, from: data)
            }
            return nil
        }
    }
}

