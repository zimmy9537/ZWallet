//
//  Bank.swift
//  ZWallet
//
//  Created by Zimmy Changela on 21/05/24.
//

import Foundation

struct Bank: Codable, Identifiable {
    var id = UUID()
    var bank_name : String
    //account details
    var ac_no : String
    var cif_no : String
    var micr_no : String
    
    //branch details
    var ifsc_code : String
    var branch_name : String
    var branch_code : String
    
    //net banking details
    var user_name: String
    var password : String
}
