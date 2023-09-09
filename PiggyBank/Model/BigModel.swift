//
//  BigModel.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 20/07/2023.
//

import Foundation

class BigModel: ObservableObject {
    
    @Published var currentView: ViewEnum = .SignInView
    @Published var currentUserBankAccount: BankAccountDTOModel? = nil
    @Published var allTransactions: [TransactionDTOModel] = []
    @Published var allRecipientTransactions: [TransactionDTOModel] = []
    var currencySymbol: String = ""
    
    public static var shared = BigModel()
    
    init() {
        print("Constructor BigModel - default")
    }
    
    init(shouldInjectMockedData: Bool) {
        print("Constructor BigModel - default")
        self.currentUserBankAccount = BankAccountDTOModel(accountId: "38469403805", accountBalance: 300, currency: "EUR", firstName: "Malo", lastName: "Fonrose", isOverdraftAllowed: 0)
        self.allTransactions = [TransactionDTOModel(id: "584", senderAccountID: "2000", recipientAccountID: "1000", amount: 300, currency: "EUR", date: 14112), TransactionDTOModel(id: "584", senderAccountID: "2000", recipientAccountID: "1000", amount: 100, currency: "USD", date: 12122)]
    }
    
    //makePayment
    
    func er() {
        print("a")
    }
    
    
    ///
    /// COMMENT ECRIRE UN TEST UNITAIRE AVEC SWIFT
    ///
    /// DESIGN ADAPTÉ A UN CLI (car bloquant) : Exemple de code Swift avec un test unitaire qui fait un appel HTTP bloquant (avec URLSession.shared.data au lieu de URLSession.shared.datatask) :
    /// Cf : https://www.avanderlee.com/concurrency/unit-testing-async-await/
    ///
    /// DESIGN ADAPTÉ A UNE APP MOBILE (car non bloquant) : La logique non bloquante est plus adaptée au code des UIs car elle ne bloque pas le thread principal.
    /// Mais, dans un test unitaire, quand on ne fait pas d'appel bloquant, on tombe sur le problème de la function de test qui fini avant la fin de l'exécution
    /// du callback (problème qu'on peut résoudre avec `waitForExpectations` and `expectation.fulfill()`).
    /// Cf : https://www.swiftbysundell.com/articles/unit-testing-asynchronous-swift-code/
    ///
    func makePayment(amount: Float64, accountID: String, currency: String) async {
        
        do {
            // L'URL de la requête
            print("Appel API")
            let urlString = "http://127.0.0.1:8080/makePayment/toAccount/\(accountID)/withAmount/\(amount)/\(currency)"

            // Convertir l'URL en objet URL
            guard let url = URL(string: urlString) else {
                print("URL invalide")
                return
            }

            // Créer une session URLSession
            let session = URLSession.shared
            
            // Créer une tâche de requête
            let task = session.dataTask(with: url) { data, response, error in
                print("Récupération résultat")
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
            }
            
            task.resume()
            await self.updateUserBankAccountDTO(accountId: accountID)
            self.currentView = .HomePiggyScreen
            
        }
        catch {
            print(error.localizedDescription)
        }
        // Démarrer la tâche
        
        
    }
    
    /// Exemple de code Swift avec un test unitaire qui fait un appel HTTP bloquant (avec URLSession.shared.data au lieu de URLSession.shared.datatask)
    /*
     struct ImageFetcher {
         enum Error: Swift.Error {
             case imageCastingFailed
         }

         func fetchImage(for url: URL) async throws -> UIImage {
             let (data, _) = try await URLSession.shared.data(from: url)
             guard let image = UIImage(data: data) else {
                 throw Error.imageCastingFailed
             }
             return image
         }
     }
     */
    
    
    func addMoney(amount: Float64, accountID: String, currency: String) async {
        
        do {
            // L'URL de la requête
            let urlString = "http://127.0.0.1:8080/addMoney/toAccount/\(accountID)/withAmount/\(amount)/\(currency)"

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
            }
            
            task.resume()
            await self.updateUserBankAccountDTO(accountId: accountID)
            if currentUserBankAccount != nil {
                self.currentView = .HomePiggyScreen
            }
            
        }
        catch {
            print(error.localizedDescription)
        }

        // Démarrer la tâche
        
        
    }
    
    func transferMoney(senderAccountID: String, recipientAccountId: String, amount: Float64) async {
        
        do {
            // L'URL de la requête
            let urlString = "http://127.0.0.1:8080/transferMoney/fromAccount/\(senderAccountID)/toAccount/\(recipientAccountId)/withAmount/\(amount)"
            //let urlString = "http://127.0.0.1:8080/transferMoney/fromAccount/2000/toAccount/1000/withAmount/10"

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
                
            }
            
            task.resume()
            if currentUserBankAccount != nil {
                await self.updateUserBankAccountDTO(accountId: senderAccountID)
                self.updateUserSenderTransactionsList(accountId: senderAccountID)
                self.currentView = .HomePiggyScreen
            }
            
        }
        catch {
            print(error.localizedDescription)
        }

        // Démarrer la tâche
        
        
    }
    
    
    /*func initializeANewBankAccount(accountID: String, firstName: String, lastName: String, accountBalance: Int64, currency: String, isOverdraftAllowed: Int64, overdraftLimit: Float64) async throws -> BankAccountDTOModel {
        
        var bankAccountDTO = BankAccountDTOModel()
        
        do {
            // L'URL de la requête
            let urlString = "http://127.0.0.1:8080/initializeAccount/withAccountId/\(accountID)/withFirstName/\(firstName)/withLastName/\(lastName)/withAccountBalance/\(accountBalance)/currency/\(currency)/overdraftAuthorization/\(isOverdraftAllowed)/overdraftLimit/\(overdraftLimit)"

            // Convertir l'URL en objet URL
            guard let url = URL(string: urlString) else {
                print("URL invalide")
                throw PiggyBankError.technicalError
            }

            // Créer une session URLSession
            let session = URLSession.shared
            
            // Créer une tâche de requête
            let task = session.dataTask(with: url) { data, response, error in
                // Vérifier s'il y a des erreurs
                if let error = error {
                    print("Erreur : \(error)")
                    throw PiggyBankError.technicalError
                }

                // Vérifier la réponse HTTP
                if let httpResponse = response as? HTTPURLResponse {
                    if !(200...299).contains(httpResponse.statusCode) {
                        print("La requête a échoué avec le code HTTP \(httpResponse.statusCode)")
                        throw PiggyBankError.technicalError
                    }
                }

                // Vérifier s'il y a des données de réponse
                guard let responseData = data else {
                    print("Aucune donnée reçue")
                    throw PiggyBankError.technicalError
                }
                
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
            
            await self.updateUserBankAccountDTO(accountId: accountID)
            if currentUserBankAccount != nil {
                self.currentView = .HomePiggyScreen
            }
            return bankAccountDTO
            
        }
        catch {
            print(error.localizedDescription)
            throw PiggyBankError.technicalError
        }
        
    }*/
    
    
    func updateUserBankAccountDTO(accountId: String) async {
        
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
                        
                        self.currentUserBankAccount = bankAccountDTO
                        
                        self.updateUserSenderTransactionsList(accountId: accountId)
                        
                        self.currentView = .HomePiggyScreen
                        
                        print("firstName = \(String(describing: self.currentUserBankAccount?.firstName))")
                        
                        if self.currentUserBankAccount?.currency ?? "nil" == "EUR" {
                            self.currencySymbol = "€"
                        }
                        if self.currentUserBankAccount?.currency ?? "nil" == "DOLLARD" {
                            self.currencySymbol = "$"
                        }
                        if self.currentUserBankAccount?.currency ?? "nil" == "POUNDS" {
                            self.currencySymbol = "£"
                        }
                        
                    }

                    
                   // Accéder aux propriétés de l'objet Swift
                    
                }
                
            }
            
            task.resume()
            
        }

        // Démarrer la tâche
        
    }
    
    
    func updateUserSenderTransactionsList(accountId: String) {
        
        do {
            // L'URL de la requête
            
            //58540395859
            
            let urlString = "http://127.0.0.1:8080/getTransactions/\(accountId)/inCurrency/\(self.currentUserBankAccount?.currency ?? "nil")"

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
                    
                    let bankAccountDTO = try decoder.decode([TransactionDTOModel].self, from: responseData)
                    
                    DispatchQueue.main.async {
                        self.allTransactions = bankAccountDTO
                    }
                    
                   // Accéder aux propriétés de l'objet Swift
                    
                }
                
            }
            
            task.resume()
            
        }

        // Démarrer la tâche
        
    }
    
    
    func updateUserRecipientTransactionsList(accountId: String) {
        
        do {
            // L'URL de la requête
            
            //58540395859
            
            let urlString = "http://127.0.0.1:8080/getRecipientTransactions/\(accountId)"

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
                    
                    let recipientTransactions = try decoder.decode([TransactionDTOModel].self, from: responseData)
                    
                    DispatchQueue.main.async {
                        
                        self.allRecipientTransactions = recipientTransactions
                        
                    }

                    
                   // Accéder aux propriétés de l'objet Swift
                    
                }
                
            }
            
            task.resume()
            
        }

        // Démarrer la tâche
        
    }
    
    
    func signIn(accountId: String) async {
        do {
            await updateUserBankAccountDTO(accountId: accountId)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func signOut() {
        
        DispatchQueue.main.async {
            self.currentUserBankAccount = nil
            self.currentView = .SignInView
        }
        
    }
    
    enum PiggyBankError: Error {
        case accountAlreadyExists
        case unknownAccount
        case inconsistentCurrency
        case insufficientAccountBalance(message: String)
        case insufficientOverdraftLimitExceeded
        case overDraftLimitUndefined
        case overDraftMustBeNegative
        case abnormallyHighSum
        
        case technicalError
    }
    

    
}
