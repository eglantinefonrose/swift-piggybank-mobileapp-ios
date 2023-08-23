//
//  BankAccountDTOModel.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 07/08/2023.
//

import SwiftUI

struct BankAccountDTOModel: Codable {
    
    var accountId: String = ""
    var accountBalance: Float64 = 0
    var currency: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var isOverdraftAllowed: Int = 0
    var overDraftLimit: Float?
}

struct TransactionDTOModel: Codable {
    
    var senderAccountDTO: BankAccountDTOModel
    var recipientAccountDTO: BankAccountDTOModel
    var amount: Float64
    var currency: String
    
}
