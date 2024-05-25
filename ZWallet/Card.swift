//
//  Card.swift
//  ZWallet
//
//  Created by Zimmy Changela on 21/05/24.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    var number: String
    var holder: String
    var expiration: String
    var bankName: String
    var pin: String
    var cvv: String
    var isDebitCard: Bool
}
