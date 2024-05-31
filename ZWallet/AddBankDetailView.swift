//
//  AddBankDetailView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 21/05/24.
//

import SwiftUI

struct AddBankDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : BankViewModel
    
    @State private var bank_name: String = ""
    @State private var ac_no: String = ""
    @State private var cif_no: String = ""
    @State private var micr_no: String = ""
    @State private var ifsc_code: String = ""
    @State private var branch_name: String = ""
    @State private var branch_code: String = ""
    @State private var user_name: String = ""
    @State private var password: String = ""
    
    // State for error message
    @State private var errorMessage: String?
    
    var body: some View {
        Form {
            TextField("Bank Name", text: $bank_name)
            Section(header: Text("Account Details")) {
                TextField("Account Number", text: $ac_no)
                TextField("CIF Number", text: $cif_no)
                TextField("MICR Number", text: $micr_no)
            }
            Section(header: Text("Branch Details")) {
                TextField("IFSC Code", text: $ifsc_code)
                TextField("Branch Name", text: $branch_name)
                TextField("Branch Code", text: $branch_code)
            }
            Section(header: Text("Net Banking Details")) {
                TextField("Username", text: $user_name)
                SecureField("Password", text: $password)
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            Button(action: saveBank) {
                Text("Save Bank Details")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Add Bank Details")
    }
    
    private func saveBank() {
        // Validate required fields
        guard !bank_name.isEmpty else {
            errorMessage = "Bank Name is required"
            return
        }

        // If all validations pass
        let bank = Bank(bank_name:bank_name, ac_no: ac_no, cif_no: cif_no, micr_no: micr_no, ifsc_code: ifsc_code, branch_name: branch_name, branch_code: branch_code, user_name: user_name, password: password)
            viewModel.addBankDetails(bank) // Save bank details to viewModel
            presentationMode.wrappedValue.dismiss()
        }
}

struct AddBankDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddBankDetailView(viewModel: .init())
    }
}
