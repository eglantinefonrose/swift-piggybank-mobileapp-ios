//
//  TransactionView.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 29/08/2023.
//

import SwiftUI

struct TransactionView: View {
    
    @ObservedObject var bigModel: BigModel
    @State var moneyAmount = ""
    @FocusState var focused: Bool?
    @State var reciepientAccountID = ""
    @Environment(\.colorScheme) var theColorScheme
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "arrow.left")
                    .bold()
                    .font(.system(size: 20))
                    .onTapGesture {
                        bigModel.currentView = .HomePiggyScreen
                    }
                Text("transfer-money")
                    .font(.largeTitle)
                    .bold()
            }
            
            ZStack {
                Rectangle()
                    .cornerRadius(20)
                    .foregroundColor(.gray)
                    .frame(height: 120)
                
                VStack(spacing: 20) {
                    HStack {
                        
                        Text("EUR")
                            .font(.title)
                        
                        Image(systemName: "chevron.down")
                        
                        Spacer()
                        
                        TextField("", text: $moneyAmount)
                            .focused($focused, equals: true)
                            .onAppear {
                              DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                self.focused = true
                              }
                            }
                            .multilineTextAlignment(.trailing)
                            .font(.title)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("amount \(String(format: "%.1f", bigModel.currentUserBankAccount?.accountBalance ?? 0))")
                        Spacer()
                        Text("no-charges")
                    }
                }.padding(20)
                
            }
            
            VStack {
                
                VStack {
                 
                 Spacer()
                 
                 HStack {
                                                     
                     Spacer()
                     TextField("recipient", text: $reciepientAccountID)
                         .disableAutocorrection(true)
                         .autocapitalization(.none)
                     Spacer()
                     Image(systemName: "qrcode")
                         .foregroundColor(.blue)
                         .font(.headline)
                     
                 }
                 
                 Spacer()

                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(7)
                .frame(height: 30)
                .padding(10)
                
            }
            
            Spacer()
            
            HStack {
                Spacer()
                    Text("transfer-money")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .padding(10)
                Spacer()
            }.background(Color.blue)
            .cornerRadius(15)
            .onTapGesture {
                Task {
                    await bigModel.transferMoney(senderAccountID: bigModel.currentUserBankAccount?.accountId ?? "nil", recipientAccountId: reciepientAccountID, amount: Float64(moneyAmount) ?? 0)
                }
            }
            
        }.padding(20)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(bigModel: BigModel.shared)
    }
}
