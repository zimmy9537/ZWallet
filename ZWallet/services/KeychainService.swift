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
    let bankKeyChain: Keychain

    init() {
        // Use your app's bundle identifier here
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.studzim.best.ZWallet"
        keychain = Keychain(service: bundleIdentifier)
        bankKeyChain = Keychain(service: bundleIdentifier)
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
    
    func deleteCard(card: Card) {
        keychain[data: card.id.uuidString] = nil
    }
    
    //bank details
    func saveBankDetails(bank: Bank) {
        do {
            let bankData = try JSONEncoder().encode(bank)
            bankKeyChain[data: bank.id.uuidString] = bankData
        } catch {
            print("Error saving bank details: \(error)")
        }
    }
    
    func loadBankDetails() -> [Bank] {
        return bankKeyChain.allKeys().compactMap { key in
            if let data = bankKeyChain[data: key] {
                return try? JSONDecoder().decode(Bank.self, from: data)
            }
            return nil
        }
    }
    
    func deleteBankDetails(bank: Bank) {
        bankKeyChain[data: bank.id.uuidString] = nil
    }
}

