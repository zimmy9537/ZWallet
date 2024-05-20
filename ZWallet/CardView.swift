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

    init(card: Card) {
        self.card = card
        self.backgroundColor = Color.random // Use random color for background
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(card.number)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .lineLimit(1) // Limit text to single line for number

            Spacer()

            HStack {
                Text(card.holder)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
                Text(card.expiration)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity) // Set maximum width to infinity
        .modifier(AspectHeight(ratio: 0.633)) // Apply the AspectHeight modifier
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
    let sampleCard = Card(number: "1234 5678 9012 3456", holder: "John Doe", expiration: "12/24")
    return CardView(card: sampleCard)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
