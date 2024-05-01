//
//  BigRootView.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 20/07/2023.
//

import SwiftUI

struct BigRootView: View {
    
    @ObservedObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
            
            if (bigModel.currentView == .SignInView) {
                SignInView(bigModel: BigModel.shared)
            }
            if (bigModel.currentView == .HomePiggyScreen) {
                HomePiggyScreen(bigModel: BigModel.shared)
            }
            if (bigModel.currentView == .AddMoneyScreen) {
                AddMoneyView(bigModel: BigModel.shared)
            }
            if (bigModel.currentView == .SendMoneyScreen) {
                SendMoneyView(bigModel: BigModel.shared)
            }
            if (bigModel.currentView == .PiggyAccountScreen) {
                PiggyAccountView(bigModel: BigModel.shared)
            }
            if (bigModel.currentView == .PiggyTranscationScreen) {
                TransactionView(bigModel: BigModel.shared)
            }
            
        }
        
    }
}

struct BigRootView_Previews: PreviewProvider {
    static var previews: some View {
        BigRootView(bigModel: BigModel.shared)
            .environmentObject(BigModel())
    }
}
