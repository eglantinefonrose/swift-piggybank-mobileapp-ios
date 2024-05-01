//
//  ContentView.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 19/07/2023.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var bigModel: BigModel
    @Environment(\.colorScheme) var theColorScheme
    @State var userName: String = ""
    @State var serverOffline: Bool = false
    
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
                
                Text("sign-in")
                    .font(.largeTitle)
                    .bold()
                    /*.onSubmit {
                        bigModel.currentView = .HomePiggyScreen
                    }*/
                
                Spacer()
                
            VStack {
                
                VStack {
                 
                 Spacer()
                 
                 HStack {
                                                     
                     Spacer()
                     
                     TextField("username", text: $userName)
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
                
                if bigModel.anyError {
                    Text(bigModel.signInErrorMessage)
                }
                
                HStack {
                    Spacer()
                        Text("sign-in")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding(7)
                    Spacer()
                }.background(Color.blue)
                .cornerRadius(15)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .onTapGesture {
                    Task {
                        await bigModel.signIn(accountId: userName)
                        //bigModel.updateUserRecipientTransactionsList(accountId: userName)
                    }
                }
                
            }
        }.onAppear(perform: {
            
        })
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(bigModel: BigModel())
    }
}
