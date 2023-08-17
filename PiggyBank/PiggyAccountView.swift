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
                    Text("\(String(bigModel.currentUser?.firstName.prefix(1) ?? ""))\(String(bigModel.currentUser?.lastName.prefix(1) ?? ""))")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                Text("\(String(bigModel.currentUser?.firstName ?? "")) \(String(bigModel.currentUser?.lastName ?? ""))")
                    .font(.title)
                
                Text("ID: \(bigModel.currentUser?.accountId ?? "")")
                
                Text("Currency : \(bigModel.currentUser?.currency ?? "nil")")
                      
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
