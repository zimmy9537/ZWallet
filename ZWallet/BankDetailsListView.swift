//
//  BankDetailsView.swift
//  ZWallet
//
//  Created by Zimmy Changela on 21/05/24.
//

import SwiftUI

struct BankDetailsListView: View {
    
    @ObservedObject var viewModel : BankViewModel
    
    @State private var banks: [Bank] = []
    @State private var showingDeleteConfirmation = false
    @State private var cardToDelete: Bank? // Track card for deletion confirmation
    
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .bottom) {
                ScrollView {
                    LazyVStack(alignment: .center) {
                        ForEach(banks) { bank in
                            NavigationLink(destination: BankDetailsView(bank: bank)) {
                                VStack(alignment: .leading) {
                                    Text(bank.bank_name)
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 8)
                                        .frame(maxWidth: .infinity)
                                }
                                .padding()
                                .background(Color.random)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .contextMenu {
                                    Button(action: {
                                        cardToDelete = bank
                                        showingDeleteConfirmation = true
                                    }) {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("My Banks")
                    .onAppear {
                        banks = viewModel.loadBankDetails()
                    }
                    .alert(isPresented: $showingDeleteConfirmation) {
                        Alert(
                            title: Text("Delete Bank Details"),
                            message: Text("Are you sure you want to delete this Bank's Details?"),
                            primaryButton: .destructive(Text("Delete")) {
                                if let cardToDelete = cardToDelete {
                                    deleteCard(cardToDelete)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                // Action to go back
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                    windowScene.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.blue)
                                Text("Back")
                            }
                        }
                    }
                }
                HStack {
                    Spacer()
                    NavigationLink(destination: AddBankDetailView(keychainService: keychainService)) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 10)
                    }
                    .background(Color.clear)
                    .padding(.bottom, 16)
                    .padding(.trailing, 16)
                }
            }
        }
    }
    
    private func deleteCard(_ bank: Bank) {
        print("here")
        if let index = banks.firstIndex(where: { $0.id == bank.id }) {
            banks.remove(at: index)
            viewModel.deleteBankDetails(bank)
            print("Deleted")
        }
    }
}

struct BankDetailsListView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock KeychainService instance for preview
        return BankDetailsListView(viewModel: .init())
    }
}
