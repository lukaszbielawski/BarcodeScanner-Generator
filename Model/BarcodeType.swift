//
//  ScanResult.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 10/08/2023.
//

import Foundation
import AVFoundation
import CoreImage
import SwiftUI

enum BarcodeType: String {
    case code39 = "Code 39"
    case code39Mod43 = "Code 39 Mod 43"
    case code93 = "Code 93"
    case code128 = "Code 128"
    case ean8 = "EAN-8"
    case ean13 = "EAN-13"
    case interleaved2of5 = "Interleaved 2 of 5"
    case itf14 = "ITF-14"
    case upce = "UPC-E"
    case aztec = "Aztec Code"
    case dataMatrix = "DataMatrix Code"
    case pdf417 = "PDF 417 Code"
    case qr = "QR Code"
    case none = "null"
}

extension BarcodeType {
    var isBarcode: Bool {
        switch self {
        case .code39, .code39Mod43, .code93, .code128, .ean8, .ean13, .interleaved2of5, .itf14, .upce:
            return true
        default:
            return false
        }
    }
    
    var isGeneratable: Bool {
        switch self {
        case .aztec, .qr, .code128, .pdf417:
            return true
        default:
            return false
        }
    }
        
    var correctionLevels: ClosedRange<Double> {
        switch self {
        case .aztec:
            return 5.0...95.0
        case .qr:
            return 1.0...4.0
        default:
            return 0.0...8.0
        }
    }
    
    var getLogo: Image {
            switch self {
            case .aztec:
                return Image("aztec")
                    .renderingMode(.template)
            case .pdf417:
                return Image("pdf417")
                    .renderingMode(.template)
            case .qr:
                return Image(systemName: "qrcode")
            default:
                return Image(systemName: "barcode")
            }
    }
    
    
}
