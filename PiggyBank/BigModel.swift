//
//  BigModel.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 20/07/2023.
//

import Foundation

class BigModel: ObservableObject {
    
    @Published var currentView: ViewEnum = .SignInView
    @Published var currentUser: BankAccountDTOModel? = nil
    
    public static var shared = BigModel()
    
    init() {
        print("Constructor BigModel - default")
    }
    
    init(shouldInjectMockedData: Bool) {
        print("Constructor BigModel - default")
        self.currentUser = BankAccountDTOModel(accountId: "38469403805", accountBalance: 300, currency: "EUR", firstName: "Malo", lastName: "Fonrose", isOverdraftAllowed: 0)
    }
    
    //makePayment
    
    func er() {
        print("a")
    }
    
    func makePayment() {
        
        do {
            // L'URL de la requête
            let urlString = "http://127.0.0.1:8080/makePayment/toAccount/45678/withAmount/234/EUR"

            // Convertir l'URL en objet URL
            guard let url = URL(string: urlString) else {
                print("URL invalide")
                return
            }

            // Créer une session URLSession
            let session = URLSession.shared
            
            // Créer une tâche de requête
            let task = session.dataTask(with: url) { data, response, error in
                // Vérifier s'il y a des erreurs
                if let error = error {
                    print("Erreur : \(error)")
                    return
                }

                // Vérifier la réponse HTTP
                if let httpResponse = response as? HTTPURLResponse {
                    if !(200...299).contains(httpResponse.statusCode) {
                        print("La requête a échoué avec le code HTTP \(httpResponse.statusCode)")
                        return
                    }
                }

                // Vérifier s'il y a des données de réponse
                guard let responseData = data else {
                    print("Aucune donnée reçue")
                    return
                }
                
                Task {
                    let decoder = JSONDecoder()
                    // Essayer de décoder le JSON en utilisant la structure BankAccountDTO
                    let bankAccountDTO = try decoder.decode(BankAccountDTOModel.self, from: responseData)
                   // Accéder aux propriétés de l'objet Swift
                   print("First Name: \(bankAccountDTO.firstName)")
                   print("Account ID: \(bankAccountDTO.accountId)")
                   print("Last Name: \(bankAccountDTO.lastName)")
                   print("Account Balance: \(bankAccountDTO.accountBalance)")
                   print("Currency: \(bankAccountDTO.currency)")
                   print("Is Overdraft Allowed: \(bankAccountDTO.isOverdraftAllowed)")
                }
                
            }
            
            task.resume()
            
        }

        // Démarrer la tâche
        
        
    }
    
    func getBankAccountDTO(accountId: String) async {
        
        do {
            // L'URL de la requête
            
            //58540395859
            
            let urlString = "http://127.0.0.1:8080/getBankAccount/\(accountId)"

            // Convertir l'URL en objet URL
            guard let url = URL(string: urlString) else {
                print("URL invalide")
                return
            }

            // Créer une session URLSession
            let session = URLSession.shared
            
            // Créer une tâche de requête
            let task = session.dataTask(with: url) { data, response, error in
                // Vérifier s'il y a des erreurs
                if let error = error {
                    print("Erreur : \(error)")
                    return
                }

                // Vérifier la réponse HTTP
                if let httpResponse = response as? HTTPURLResponse {
                    if !(200...299).contains(httpResponse.statusCode) {
                        print("La requête a échoué avec le code HTTP \(httpResponse.statusCode)")
                        return
                    }
                }

                // Vérifier s'il y a des données de réponse
                guard let responseData = data else {
                    print("Aucune donnée reçue")
                    return
                }
                
                Task {
                   
                    let decoder = JSONDecoder()
                    // Essayer de décoder le JSON en utilisant la structure BankAccountDTO
                    
                    let bankAccountDTO = try decoder.decode(BankAccountDTOModel.self, from: responseData)
                    
                    DispatchQueue.main.async {
                        self.currentUser = bankAccountDTO
                        print("firstName = \(String(describing: self.currentUser?.firstName))")
                        self.currentView = .HomePiggyScreen
                    }
                    
                    
                   // Accéder aux propriétés de l'objet Swift
                    
                }
                
            }
            
            task.resume()
            
        }

        // Démarrer la tâche
        
    }
    
    func signOut(accoundId: String) async {
        
        DispatchQueue.main.async {
            self.currentUser = nil
            self.currentView = .SignInView
        }
        
    }
    

    
}
