//
//  QRCodeView.swift
//  PiggyBank
//
//  Created by Eglantine Fonrose on 03/11/2023.
//

import SwiftUI

struct QRCodeView: View {
    
    var body: some View {
        
        Text("QR")
        Image(uiImage: UIImage(data: returnData(str: "2000"))!)
            .resizable()
            .frame(width: 300, height: 300)
        
    }
    
}

func returnData(str : String) -> Data {
    
    let filter = CIFilter (name: "CIQRCodeGenerator")
    let data = str.data(using: .ascii, allowLossyConversion: false)
    filter?.setValue (data, forKey: "inputMessage")
    let image = filter?.outputImage
    let uiimage = UIImage(ciImage: image!)
    return uiimage.pngData()!
    
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
