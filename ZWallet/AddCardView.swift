//
//  AddCardView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI

import SwiftUI

struct AddCardView: View {
    @State private var bankName = ""
    @State private var cardNumber = ""
    @State private var cardHolder = ""
    @State private var expirationDate = ""
    @State private var cvv = ""
    @State private var pin = ""
    @State private var isDebitCard: Bool = true // Track card type

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CardViewModel

    // State for error message
    @State private var errorMessage: String?

    var body: some View {
        Form {
            HStack {
                Toggle(isOn: $isDebitCard) { // Toggle for card type
                    Text(isDebitCard ? "Debit" : "Credit")
                }
                Spacer()
            }

            Section(header: Text("Card Information")) {
                TextField("Bank Name", text: $bankName)
                TextField("Card Number", text: $cardNumber)
                    .keyboardType(.numberPad)
                    .onChange(of: cardNumber) { newValue in
                        // Ensure card number does not exceed 16 digits and contains only numbers
                        if newValue.count > 16 {
                            cardNumber = String(newValue.prefix(16))
                        }
                        cardNumber = newValue.filter { $0.isNumber }
                    }
                TextField("Card Holder", text: $cardHolder)
                TextField("Expiration Date", text: $expirationDate)
                SecureField("CVV", text: $cvv) // Hides input with black dots
                    .keyboardType(.numberPad)
                    .onChange(of: cvv) { newValue in
                        // Ensure CVV does not exceed 3 digits and contains only numbers
                        if newValue.count > 3 {
                            cvv = String(newValue.prefix(3))
                        }
                        cvv = newValue.filter { $0.isNumber }
                    }
                SecureField("PIN", text: $pin) // Hides input with black dots
                    .keyboardType(.numberPad)
                    .onChange(of: pin) { newValue in
                        // Ensure PIN does not exceed 4 digits and contains only numbers
                        if newValue.count > 4 {
                            pin = String(newValue.prefix(4))
                        }
                        pin = newValue.filter { $0.isNumber }
                    }
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
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
        // Validate all fields
        guard !bankName.isEmpty else {
            errorMessage = "Bank Name is required."
            return
        }
        guard !cardNumber.isEmpty else {
            errorMessage = "Card Number is required."
            return
        }
        guard cardNumber.count == 16 else {
            errorMessage = "Card Number must be 16 digits."
            return
        }
        guard !cardHolder.isEmpty else {
            errorMessage = "Card Holder is required."
            return
        }
        guard !expirationDate.isEmpty else {
            errorMessage = "Expiration Date is required."
            return
        }
        guard !cvv.isEmpty else {
            errorMessage = "CVV is required."
            return
        }
        guard cvv.count == 3 else {
            errorMessage = "CVV must be 3 digits."
            return
        }
        guard !pin.isEmpty else {
            errorMessage = "PIN is required."
            return
        }
        guard pin.count == 4 else {
            errorMessage = "PIN must be 4 digits."
            return
        }

        // If all validations pass
        let card = Card(number: cardNumber, holder: cardHolder, expiration: expirationDate, bankName: bankName, pin: pin, cvv: cvv, isDebitCard: isDebitCard)
        viewModel.addCards(card) // Save PIN to keychain
        presentationMode.wrappedValue.dismiss()
    }
}


struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        return AddCardView(viewModel: .init())
    }
}
