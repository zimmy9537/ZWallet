//
//  DetailCardView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 20/05/24.
//

import SwiftUI



struct DetailCardView: View {
    let card: Card

    var body: some View {
        CardView(card: card, showMaskedNumber: false)
            .padding()
            .navigationTitle("Card Details")
    }
}

struct DetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCard = Card(
            number: "1234567890123456",
            holder: "John Doe",
            expiration: "12/24",
            bankName: "IDFC",
            pin: "1234",
            isDebitCard: true
        )
        return DetailCardView(card: sampleCard)
            .previewLayout(.sizeThatFits)
    }
}
