//
//  BigRootView.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 20/07/2023.
//

import SwiftUI

struct BigRootView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
            
            if (bigModel.currentView == .SignInView) {
                ContentView()
            }
            if (bigModel.currentView == .HomePiggyScreen) {
                HomePiggyScreen()
            }
            if (bigModel.currentView == .AddMoneyScreen) {
                AddMoneyView()
            }
            if (bigModel.currentView == .SendMoneyScreen) {
                SendMoneyView()
            }
            if (bigModel.currentView == .PiggyAccountScreen) {
                PiggyAccountView()
            }
            
        }
        
    }
}

struct BigRootView_Previews: PreviewProvider {
    static var previews: some View {
        BigRootView()
            .environmentObject(BigModel())
    }
}
