//
//  TranscationDTOModel.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 28/08/2023.
//

import SwiftUI

struct TransactionDTOModel: Codable, Identifiable {
    
    var id: String
    var senderAccountID: String
    var recipientAccountID: String
    var amount: Float64
    var currency: String
    var date: Int64
    
}
