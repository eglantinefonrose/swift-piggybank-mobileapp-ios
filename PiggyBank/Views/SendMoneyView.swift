//
//  SE.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 17/08/2023.
//

//
//  AddMoneyView.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 20/07/2023.
//

import SwiftUI

struct SendMoneyView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var moneyAmount = ""
    @FocusState var focused: Bool?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "arrow.left")
                    .bold()
                    .font(.system(size: 20))
                    .onTapGesture {
                        bigModel.currentView = .HomePiggyScreen
                    }
                Text("send-money")
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
            
            Spacer()
            
            HStack {
                Spacer()
                    Text("send-money")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .padding(10)
                Spacer()
            }.background(Color.blue)
            .cornerRadius(15)
            .onTapGesture {
                Task {
                    print("🧙‍♀️")
                    await bigModel.makePayment(amount: Float64(moneyAmount) ?? 0, accountID: bigModel.currentUserBankAccount?.accountId ?? "nil", currency: "EUR")
                }
            }
            
        }.padding(20)
    }
}

struct SendMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SendMoneyView()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
