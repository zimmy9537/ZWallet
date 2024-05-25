//
//  BankDetailsView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 25/05/24.
//

import SwiftUI

struct BankDetailsView: View {
    var bank: Bank
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(bank.bank_name)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)
            
            Group {
                Text("Account Details")
                    .font(.title2)
                    .bold()
                DetailRow(label: "Account Number", value: bank.ac_no)
                DetailRow(label: "CIF Number", value: bank.cif_no)
                DetailRow(label: "MICR Number", value: bank.micr_no)
            }
            
            Group {
                Text("Branch Details")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)
                DetailRow(label: "IFSC Code", value: bank.ifsc_code)
                DetailRow(label: "Branch Name", value: bank.branch_name)
                DetailRow(label: "Branch Code", value: bank.branch_code)
            }
            
            Group {
                Text("Net Banking Details")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)
                DetailRow(label: "User Name", value: bank.user_name)
                DetailRow(label: "Password", value: bank.password)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Bank Details")
    }
}

struct DetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 5)
    }
}

struct BankDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let bank = Bank(
            bank_name: "IDFC",
            ac_no: "1234567890",
            cif_no: "123456789",
            micr_no: "123456",
            ifsc_code: "EXAMPL12345",
            branch_name: "Example Branch",
            branch_code: "1234",
            user_name: "exampleUser",
            password: "examplePassword"
        )
        
        NavigationView {
            BankDetailsView(bank: bank)
        }
    }
}
