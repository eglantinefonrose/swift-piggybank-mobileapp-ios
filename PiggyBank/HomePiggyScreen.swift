//
//  HomePiggyScreen.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 20/07/2023.
//

import SwiftUI

struct HomePiggyScreen: View {
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    var body: some View {
        VStack {
                        
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.brown)
                    Text("EF")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Acceuil")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            
            VStack(spacing: 15) {
                VStack {
                    HStack {
                        Text("XXX,XX")
                            .font(.system(size: 56))
                            .bold()
                        Text("$")
                            .font(.system(size: 36))
                            .bold()
                        Spacer()
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.blue)
                    }
                    HStack {
                        Text("Euro")
                            .font(.title3)
                        Spacer()
                    }
                }
                
                VStack {
                    
                    HStack {
                        Text("Transactions")
                        Spacer()
                        Text("Tout voir")
                            .foregroundColor(.blue)
                    }
                }
                
            }
            
            Spacer()
            
            VStack {
                
                HStack {
                    Spacer()
                        Text("Ajouter de l'argent")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding(10)
                    Spacer()
                }.background(Color.blue)
                .cornerRadius(15)
                .onTapGesture {
                    bigModel.currentView = .AddMoneyScreen
                }
                
                HStack {
                    Spacer()
                        Text("Envoyer de l'argent")
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                            .padding(10)
                    Spacer()
                }.background(Color.gray)
                .cornerRadius(15)
                
            }
            
        }.padding(20)
    }
}

struct HomePiggyScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomePiggyScreen()
    }
}
