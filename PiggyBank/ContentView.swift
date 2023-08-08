//
//  ContentView.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 19/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @Environment(\.colorScheme) var theColorScheme
    @State var userName: String = ""
    
    var body: some View {
        ZStack {
            
            if theColorScheme == .light {
                Color.gray
                    .opacity(0.25)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.black
                .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                
                Spacer()
                
                Text("Sign in")
                    .font(.largeTitle)
                    .bold()
                    .onTapGesture {
                        
                    }
                
                Spacer()
                
            VStack {
                
                VStack {
                 
                 Spacer()
                 
                 HStack {
                                                     
                     Spacer()
                     
                     TextField("Username", text: $userName)
                         .disableAutocorrection(true)
                         .autocapitalization(.none)
                     
                 }
                 
                 Spacer()

                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(7)
                .frame(height: 30)
                .padding(10)
                
            }
                
                Spacer()
                
                Spacer()
                
                HStack {
                    Spacer()
                        Text("Sign in")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding(7)
                            .onTapGesture {
                                bigModel.makePayment()
                                for i in 0...bigModel.bankAccountsDTO.count {
                                    print("name = \(bigModel.bankAccountsDTO[i].firstName)")
                                    print(bigModel.bankAccountsDTO.count)
                                    print("❤️‍🔥")
                                }
                            }
                    Spacer()
                }.background(Color.blue)
                .cornerRadius(15)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .onTapGesture {
                    bigModel.currentView = .HomePiggyScreen
                }
                
            }
        }.onAppear(perform: {
            bigModel.bankAccountsDTO = DB_Manager().getBankAccountsDTO()
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
