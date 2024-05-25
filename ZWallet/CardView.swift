//
//  CardView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI

struct AspectHeight: ViewModifier {
    let ratio: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .frame(height: geometry.size.width * ratio)
        }
    }
}

struct CardView: View {
    let card: Card
    let backgroundColor: Color
    let showMaskedNumber: Bool

    init(card: Card, showMaskedNumber: Bool = true) {
        self.card = card
        self.backgroundColor = Color.random // Set desired background color
        self.showMaskedNumber = showMaskedNumber
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(card.isDebitCard ? "DEBIT" : "CREDIT")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text(card.bankName)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }

            Spacer()
            Spacer()

            Text(showMaskedNumber ? maskedCardNumber(card.number) : formatCardNumber(card.number))
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .lineLimit(1) // Limit text to single line for number

            Spacer()

            HStack(alignment: .bottom) {
                Text(card.holder)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text(showMaskedNumber ? maskCvv(card.cvv) : card.cvv)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.white)
                Spacer()
                Text(card.expiration)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity)
        .modifier(AspectHeight(ratio: 0.633)) // Apply the AspectHeight modifier
    }
    
    private func maskCvv(_ cvv:String) -> String {
        guard cvv.count == 3 else { return cvv }
        return "***"
    }

    // Function to mask the card number except for the last four digits
    private func maskedCardNumber(_ cardNumber: String) -> String {
        guard cardNumber.count > 4 else { return cardNumber }
        let maskedPart = String(repeating: "*", count: cardNumber.count - 4)
        let visiblePart = cardNumber.suffix(4)
        return maskedPart + visiblePart
    }

    // Function to format the card number with spaces every four digits
    private func formatCardNumber(_ cardNumber: String) -> String {
        var formattedNumber = ""
        var index = 0
        for character in cardNumber {
            formattedNumber.append(character)
            index += 1
            // Insert a space after every fourth character
            if index % 4 == 0 && index < cardNumber.count {
                formattedNumber.append(" ")
            }
        }
        return formattedNumber
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCard = Card(
            number: "1234567890123456",
            holder: "John Doe",
            expiration: "12/24",
            bankName: "IDFC",
            pin: "1234",
            cvv: "123",
            isDebitCard: true
        )
        return CardView(card: sampleCard)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
