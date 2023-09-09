//
//  PiggyBankApp.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 19/07/2023.
//

import SwiftUI

@main
struct PiggyBankApp: App {
    var body: some Scene {
        WindowGroup {
            BigRootView()
                .environmentObject(BigModel())
                .environment(\.locale, Locale.init(identifier: "es"))
        }
    }
}
