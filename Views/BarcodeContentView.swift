//
//  MetadataTextContentView.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 10/08/2023.
//

import Foundation
import SwiftUI

struct BarcodeContentView: View {
    @EnvironmentObject var scanResult: ScanResult
    
    var didTap: () -> Void
    
    var body: some View {
        Button(action: didTap) {
                Text(scanResult.text)
                    .foregroundColor(Color(uiColor: scanResult.text.isValidURL ? .accentColor : .secondaryColor))
                    .underline(scanResult.text.isValidURL)
                    .padding(8)
                    .background(Color(uiColor: .primaryColor))
                    .cornerRadius(16)
                    .padding()
        }.buttonStyle(.plain)
    }
}

struct BarcodeContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeContentView {
            
        } 
        .environmentObject(ScanResult())
    }
}



