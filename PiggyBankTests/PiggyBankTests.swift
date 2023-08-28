//
//  PiggyBankTests.swift
//  PiggyBankTests
//
//  Created by Eglantine Fonrose on 19/07/2023.
//

import XCTest
@testable import PiggyBank

final class PiggyBankTests: XCTestCase {

    var bigModel: BigModel!
    
    override func setUp() {
        bigModel = BigModel(shouldInjectMockedData: true)
    }
    
    override func tearDown() {
        bigModel = nil
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
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

    func testMakeA10EURPaymentWorks() {
        
        // Initialisation du test
        // Remarque : Le compte créé dans le BigModel possède 300€ quand il est créé via ce constructeur
        let bigModel: BigModel! = BigModel(shouldInjectMockedData: true)
        
        // Execution de l'action (à tester)
        //await bigModel.makePayment(amount: 10, accountID: "38469403805", currency: "EUR")
        
        // Create an expectation
        let expectation = self.expectation(description: "Payment")
        
        // L'URL de la requête
        let urlString = "http://127.0.0.1:8080/makePayment/toAccount/1000/withAmount/10/EUR"

        // Convertir l'URL en objet URL
        guard let url = URL(string: urlString) else {
            print("URL invalide")
            return
        }

        // Créer une tâche pour exécuter la requête HTTP et traiter son résultat
        print("Appel API ...")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
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
                
                // Essayer de décoder le JSON en utilisant la structure BankAccountDTO
                let decoder = JSONDecoder()
                let bankAccountDTO = try decoder.decode(BankAccountDTOModel.self, from: responseData)
                // Accéder aux propriétés de l'objet Swift
                print("First Name: \(bankAccountDTO.firstName)")
                print("Account ID: \(bankAccountDTO.accountId)")
                print("Last Name: \(bankAccountDTO.lastName)")
                print("Account Balance: \(bankAccountDTO.accountBalance)")
                print("Currency: \(bankAccountDTO.currency)")
                print("Is Overdraft Allowed: \(bankAccountDTO.isOverdraftAllowed)")
                
                // Met à jour le BigModel avec les nouvelles infos sur le BankAccount
                bigModel.currentUserBankAccount = bankAccountDTO
                
                // Débloque le thread qui est en attente via l'instruction `await fulfillment(of: [expectation])`
                // Remarque : Le thread qui est bloqué est celui qui a lancé le test
                expectation.fulfill()
            } catch let theError {
                print("theError=[\(theError)]")
                
                // En cas d'erreur, on fait le choix de mettre le currentUserBankAccount à nil, comme ça
                // on sait que le Assert va échouer
                // Remarque : Il aurait aussi échoué si on ne changeait rien vu que le montant serait resté à 300€
                bigModel.currentUserBankAccount = nil
                expectation.fulfill()
            }
        }
        task.resume()
                
        // Bloque le thread qui a lancé le test, en attendant que le résultat de la requête HTTP
        // soit arrivé et que `expectation.fulfill()` soit appelé pour le débloquer
        waitForExpectations(timeout: 5, handler: nil)
    
    
        // ASSERTS (vérifications) : Suite au "paiement de 10€ vers le compte 38469403805", on vérifie que le nouveau solde est de 290€
        if let resultValue = bigModel.currentUserBankAccount?.accountBalance {
            let expectedAccountBalance = Float64(290)    // Comme le compte a été initialisé à 300€ et que nous avons fait un virement de 10€, on attend une valeur de 290€
            XCTAssert(expectedAccountBalance == resultValue)
        } else {
            XCTFail("Le current user n'a pas de valeur")
        }
    
    }
    
    func testMakeA10EURMoneyAddWorks() {
        
        // Initialisation du test
        // Remarque : Le compte créé dans le BigModel possède 300€ quand il est créé via ce constructeur
        let bigModel: BigModel! = BigModel(shouldInjectMockedData: true)
        
        // Execution de l'action (à tester)
        //await bigModel.makePayment(amount: 10, accountID: "38469403805", currency: "EUR")
        
        // Create an expectation
        let expectation = self.expectation(description: "Payment")
        
        // L'URL de la requête
        let urlString = "http://127.0.0.1:8080/addMoney/toAccount/2000/withAmount/10/EUR"

        // Convertir l'URL en objet URL
        guard let url = URL(string: urlString) else {
            print("URL invalide")
            return
        }

        // Créer une tâche pour exécuter la requête HTTP et traiter son résultat
        print("Appel API ...")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
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
                
                // Essayer de décoder le JSON en utilisant la structure BankAccountDTO
                let decoder = JSONDecoder()
                let bankAccountDTO = try decoder.decode(BankAccountDTOModel.self, from: responseData)
                // Accéder aux propriétés de l'objet Swift
                print("First Name: \(bankAccountDTO.firstName)")
                print("Account ID: \(bankAccountDTO.accountId)")
                print("Last Name: \(bankAccountDTO.lastName)")
                print("Account Balance: \(bankAccountDTO.accountBalance)")
                print("Currency: \(bankAccountDTO.currency)")
                print("Is Overdraft Allowed: \(bankAccountDTO.isOverdraftAllowed)")
                
                // Met à jour le BigModel avec les nouvelles infos sur le BankAccount
                bigModel.currentUserBankAccount = bankAccountDTO
                
                // Débloque le thread qui est en attente via l'instruction `await fulfillment(of: [expectation])`
                // Remarque : Le thread qui est bloqué est celui qui a lancé le test
                expectation.fulfill()
            } catch let theError {
                print("theError=[\(theError)]")
                
                // En cas d'erreur, on fait le choix de mettre le currentUserBankAccount à nil, comme ça
                // on sait que le Assert va échouer
                // Remarque : Il aurait aussi échoué si on ne changeait rien vu que le montant serait resté à 300€
                bigModel.currentUserBankAccount = nil
                expectation.fulfill()
            }
        }
        task.resume()
                
        // Bloque le thread qui a lancé le test, en attendant que le résultat de la requête HTTP
        // soit arrivé et que `expectation.fulfill()` soit appelé pour le débloquer
        waitForExpectations(timeout: 5, handler: nil)
    
    
        // ASSERTS (vérifications) : Suite au "paiement de 10€ vers le compte 38469403805", on vérifie que le nouveau solde est de 290€
        if let resultValue = bigModel.currentUserBankAccount?.accountBalance {
            let expectedAccountBalance = Float64(310)    // Comme le compte a été initialisé à 300€ et que nous avons fait un virement de 10€, on attend une valeur de 290€
            XCTAssert(expectedAccountBalance == resultValue)
        } else {
            XCTFail("Le current user n'a pas de valeur")
        }
    
    }

}
