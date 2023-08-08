//
//  BigModel.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 20/07/2023.
//

import Foundation

class BigModel: ObservableObject {
    
    @Published var currentView: ViewEnum = .SignInView
    @Published var bankAccountsDTO: [BankAccountDTOModel] = []
    
    public static var shared = BigModel()
    
    init() {
        print("Constructor BigModel - default")
    }
    
    //makePayment
    
    func er() {
        print("a")
    }
    
    func makePayment() {
        
        do {
            // L'URL de la requête
            let urlString = "http://127.0.0.1:8080/makePayment/toAccount/231231231/withAmount/120/EUR"

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

    
}
