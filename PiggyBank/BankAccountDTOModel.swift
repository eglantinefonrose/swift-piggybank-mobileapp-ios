//
//  BankAccountDTOModel.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 07/08/2023.
//

import SwiftUI

class BankAccountDTOModel: Codable {
    public var firstName: String = ""
    public var accountId: Int64 = 0
    public var lastName: String = ""
    public var accountBalance: Float64 = 0
    public var currency: String = ""
    public var isOverdraftAllowed: Int64 = 0
    public var overDraftLimit: Float64 = 0
}
