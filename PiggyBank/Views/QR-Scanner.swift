//
//  QR-Scanner.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 03/11/2023.
//

import SwiftUI
import CodeScanner

struct QR_Scanner: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a QR code to get started."
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    Task {
                        await bigModel.transferMoney(senderAccountID: code.string, recipientAccountId: "1000", amount: Float64(100))
                    }
                    self.isPresentingScanner = false
                }
            }
        )
    }
    
    var body: some View {
        Text(scannedCode)
            .onTapGesture {
                self.isPresentingScanner = true
            }.sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
    }
}

struct QR_Scanner_Previews: PreviewProvider {
    static var previews: some View {
        QR_Scanner()
    }
}
