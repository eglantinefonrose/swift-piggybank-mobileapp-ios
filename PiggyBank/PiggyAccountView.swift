//
//  PiggyAccountView.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 16/08/2023.
//

import SwiftUI

struct PiggyAccountView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image(systemName: "house")
                Spacer()
                Text("Account Details")
                    .bold()
                Spacer()
            }
            
            Spacer()
            
            VStack {
                
                Spacer()
                
                ZStack {
                    Circle()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.blue)
                    Text("\(String(bigModel.currentUserBankAccount?.firstName.prefix(1) ?? ""))\(String(bigModel.currentUserBankAccount?.lastName.prefix(1) ?? ""))")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                Text("\(String(bigModel.currentUserBankAccount?.firstName ?? "")) \(String(bigModel.currentUserBankAccount?.lastName ?? ""))")
                    .font(.title)
                
                Text("ID: \(bigModel.currentUserBankAccount?.accountId ?? "")")
                
                Text("Currency : \(bigModel.currentUserBankAccount?.currency ?? "nil")")
                      
                Spacer()
                
                /*HStack {
                    Image(systemName: "pencil.circle")
                        .foregroundColor(.blue)
                    Text("Modifier le profil")
                        .foregroundColor(.blue)
                        .underline()
                }*/
                
                ZStack {
                    Rectangle()
                        .cornerRadius(15)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                    .frame(height: 50)
                    Text("Sign out")
                        .bold()
                        .foregroundColor(.white)
                        .onTapGesture {
                            bigModel.signOut()
                        }
                }
                
            }
            
            Spacer()
            
        }.padding(20)
        
    }
}

struct PiggyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        PiggyAccountView()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
