//
//  AddCardView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI

struct AddCardView: View {
    @State private var cardNumber = ""
    @State private var cardHolder = ""
    @State private var expirationDate = ""
    @State private var cvv = ""
    
    @Environment(\.presentationMode) var presentationMode
    let keychainService: KeychainService

    var body: some View {
        Form {
            Section(header: Text("Card Information")) {
                TextField("Card Number", text: $cardNumber)
                    .keyboardType(.numberPad)
                TextField("Card Holder", text: $cardHolder)
                TextField("Expiration Date", text: $expirationDate)
                TextField("CVV", text: $cvv)
                    .keyboardType(.numberPad)
            }
            
            Button(action: saveCard) {
                Text("Save Card")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Add Card")
    }

    func saveCard() {
        let card = Card(number: cardNumber, holder: cardHolder, expiration: expirationDate)
        keychainService.saveCard(card: card)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock KeychainService instance for preview
        let keychainService = KeychainService()
        return AddCardView(keychainService: keychainService)
    }
}
