//
//  TranscationDTOModel.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 28/08/2023.
//

import SwiftUI

struct TransactionDTOModel: Codable {
    
    var senderAccountDTOID: String
    var recipientAccountDTOID: String
    var amount: Float64
    var currency: String
    
}
