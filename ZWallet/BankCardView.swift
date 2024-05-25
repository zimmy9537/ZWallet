//
//  BankCardView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 24/05/24.
//

import SwiftUI

struct BankCardView: View {
    let bank: Bank
    let backgroundColor: Color

    init(bank: Bank) {
        self.bank = bank
        self.backgroundColor = Color.random // Set desired background color
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(bank.branch_name)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 8)
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct BankCardView_previews: PreviewProvider {
    static var previews: some View {
        let sampleBank = Bank(
            bank_name: "IDFC",
            ac_no: "123456789012",
            cif_no: "123456",
            micr_no: "123456789",
            ifsc_code: "IFSC0001234",
            branch_name: "Main Branch",
            branch_code: "001",
            user_name: "john_doe",
            password: "password"
        )
        return BankCardView(bank: sampleBank)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
