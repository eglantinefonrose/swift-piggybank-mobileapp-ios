//
//  HomePiggyScreen.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 20/07/2023.
//

import SwiftUI

struct HomePiggyScreen: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @ObservedObject var bigModel: BigModel
    @State private var showCategorySelector = false
    @State var selectedFilter = TransactionFilter.All
    
    var body: some View {
        VStack {
                        
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                    Text("\(String(bigModel.currentUserBankAccount?.firstName.prefix(1) ?? ""))\(String(bigModel.currentUserBankAccount?.lastName.prefix(1) ?? ""))")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                }.onTapGesture {
                   bigModel.currentView = .PiggyAccountScreen
                }
                
                Spacer()
                Text("home")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            
            VStack(spacing: 15) {
                VStack {
                    HStack {
                        
                        Text(String(format: "%.1f", bigModel.currentUserBankAccount?.accountBalance ?? 0))
                            .font(.system(size: 56))
                            .bold()
                        /*Text(bigModel.currencySymbol)
                            .font(.system(size: 36))
                            .bold()*/
                        Text(bigModel.currentUserBankAccount?.currency.currencySymbol() ?? "nil")
                            .font(.system(size: 36))
                            .bold()
                        Spacer()
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.blue)
                    }
                    /*HStack {
                        Text("Euro")
                            .font(.title3)
                        Spacer()
                    }*/
                }
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                    
                    VStack {
                        
                        HStack {
                            Text("transactions")
                                .font(.title2)
                            Spacer()
                            Picker("", selection: $selectedFilter.animation()) {
                                ForEach(TransactionFilter.allFilters, id: \.self) { filter in
                                    Text(filter.rawValue)
                                }
                            }
                        }
                        
                        List(filteredTaskItems()) { transaction in
                            
                             HStack {
                                 
                                 VStack {
                                     Text( "\((transaction.senderAccountID != bigModel.currentUserBankAccount?.accountId ?? "nil") ? transaction.senderAccountID : transaction.recipientAccountID)")
                                         .font(.title3)
                                         .bold()
                                     Text("\(String(Date(timeIntervalSince1970: TimeInterval(transaction.date)).get(.hour))):\(String(Date(timeIntervalSince1970: TimeInterval(transaction.date)).get(.minute))):\(String(Date(timeIntervalSince1970: TimeInterval(transaction.date)).get(.second)))")
                                 }
                                 
                                 Spacer()
                                 
                                 Text("\((transaction.recipientAccountID == bigModel.currentUserBankAccount?.accountId ?? "nil") ? "+" : "-")\(String(format: "%.1f", transaction.amount)) \(transaction.currency)")
                                     .font(.title3)
                                 
                             }.padding(.vertical, 7)
                            .background(Color.gray)
                            .listRowBackground(Color.gray)
                        }.listStyle(PlainListStyle())
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Picker("", selection: $selectedFilter.animation()) {
                                    ForEach(TransactionFilter.allFilters, id: \.self) { filter in
                                        Text(filter.rawValue)
                                    }
                                }
                            }
                        }
                        
                    }.padding(20)
                    
                }
                
                Spacer()
                
            }
            
            Spacer()
            
            VStack {
                
                /*HStack {
                    Spacer()
                        Text("add-money")
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
                        Text("send-money")
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                            .padding(10)
                    Spacer()
                }.background(Color.gray)
                .cornerRadius(15)
                .onTapGesture {
                    bigModel.currentView = .SendMoneyScreen
                }*/
                
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
                    bigModel.currentView = .PiggyTranscationScreen
                }
                
                HStack {
                    Spacer()
                        Text("Recieve money")
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                            .padding(10)
                    Spacer()
                }.background(Color.gray)
                .cornerRadius(15)
                .onTapGesture {
                    bigModel.currentView = .SendMoneyScreen
                }
            }
            
        }.padding(20)
            .sheet(isPresented: $showCategorySelector) {
                VStack {
                    
                }
            }
    }
    
    private func filteredTaskItems() -> [TransactionDTOModel] {
        
        if selectedFilter == TransactionFilter.All {
            return bigModel.allTransactions
        }
        
        if selectedFilter == TransactionFilter.Gain {
            var transactions: [TransactionDTOModel] = []
            
            for i in 0..<bigModel.allTransactions.count {
                if (bigModel.allTransactions[i].recipientAccountID == bigModel.currentUserBankAccount?.accountId ?? "nil") {
                    transactions.append(bigModel.allTransactions[i])
                }
                else {}
            }
            return transactions
        }
        
        if selectedFilter == TransactionFilter.Waste {
            var transactions: [TransactionDTOModel] = []
            
            for i in 0..<bigModel.allTransactions.count {
                if (bigModel.allTransactions[i].senderAccountID == bigModel.currentUserBankAccount?.accountId ?? "nil") {
                    transactions.append(bigModel.allTransactions[i])
                }
                else {}
            }
            return transactions
        }
        
        return bigModel.allTransactions
        
    }

    
}

extension String {
    func currencySymbol() -> String {
        if self == "EUR" {
            return "€"
        }
        if self == "USD" {
            return "$"
        }
        if self == "JPY" {
            return "¥"
        }
        if self == "GBP" {
            return "£"
        }
        if self == "KRW" {
            return "₩"
        }
        else {
            return self
        }
    }
}

enum TransactionFilter: String {
    
    static var allFilters: [TransactionFilter] {
        return [.All, .Gain, .Waste]
    }
    
    case All = "All"
    case Gain = "Gain"
    case Waste = "Waste"
    
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

func dateFromJd(jd : Int64) -> Date {
    let JD_JAN_1_1970_0000GMT = 2440587.5
    return  Date(timeIntervalSince1970: (Double(jd) - JD_JAN_1_1970_0000GMT) * 86400)
}

struct HomePiggyScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomePiggyScreen(bigModel: BigModel.shared)
            .environment(\.locale, Locale.init(identifier: "en"))
    }
}
