//
//  ScannerView.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 10/08/2023.
//

import SwiftUI
import UIKit

struct ScannerView: View {
    
    @StateObject var scanResult: ScanResult = ScanResult()
    @State var isShowingTextContentDetails: Bool = false
    @State var isPopupShown: Bool = false  {
        didSet {
            if isPopupShown {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isPopupShown = false
                    }
                }
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MetadataScanner()
                .environmentObject(scanResult)
            VStack {
                TopPopupView(isTriggered: $isPopupShown, text: "Copied", systemImage: "doc.on.clipboard.fill", color: .accentColor)
                Spacer()
                MetadataTextContentView() {
                    
                    if scanResult.text != "No pattern detected" {
                        
                        if scanResult.text.isValidURL {
                            if let url = URL(string: scanResult.text) {
                                UIApplication.shared.open(url)
                            }
                        } else {
                            isPopupShown = true
                            UIPasteboard.general.string = scanResult.text
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }
                        
                    }
                }
                .environmentObject(scanResult)
            }
        }
        
    }
}






struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
            .preferredColorScheme(.dark)
    }
}
