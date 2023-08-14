//
//  ScanResult.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 12/08/2023.
//

import Foundation

class ScanResult: ObservableObject {
    @Published var text: String = "No pattern detected"
    @Published var metadataType: BarcodeType = .none
}
