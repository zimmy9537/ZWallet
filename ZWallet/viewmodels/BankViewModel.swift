//
//  BankViewModel.swift
//  ZWallet
//
//  Created by Zimmy Changela on 31/05/24.
//

import Foundation

class BankViewModel : ObservableObject {
    @Published var banks : [Bank] = []
    private let keyChainService : KeychainService
        
    init(keyChainService: KeychainService) {
        self.keyChainService = keyChainService
        loadBankDetails()
    }
    
    func loadBankDetails() {
        banks = keyChainService.loadBankDetails()
    }
    
    func addBankDetails(_ bank: Bank) {
        banks.append(bank)
        objectWillChange.send()
    }
    
    func deleteBankDetails(_ bank:Bank) {
        if let index = banks.firstIndex(where: {$0.id == bank.id}) {
            banks.remove(at: index)
            keyChainService.deleteBankDetails(bank: bank)
            objectWillChange.send()
        }
    }
}
