//
//  MetadataTextContentDetailsView.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 10/08/2023.
//

import Foundation
import SwiftUI

struct MetadataTextContentDetailsView: View {
    
    @EnvironmentObject var scanResult: ScanResult
    
    var body: some View {
        VStack {
            Text("Metadata type: \(scanResult.metadataType.rawValue)")
            Text("Content: \(scanResult.text)")
        }
    }
}

struct MetadataTextContentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MetadataTextContentDetailsView()
            .environmentObject(ScanResult())
    }
}
