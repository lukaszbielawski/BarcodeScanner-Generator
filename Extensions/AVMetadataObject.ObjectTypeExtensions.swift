//
//  AVMetadataObject.ObjectType+CaseIterable.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 10/08/2023.
//

import Foundation
import AVFoundation

extension AVMetadataObject.ObjectType: CaseIterable {
    public static var allCases: [AVMetadataObject.ObjectType] {
        [.code39, .code39Mod43, .code93, .code128, .ean8, .ean13, .interleaved2of5, .itf14, .upce,
         .aztec, .dataMatrix, .pdf417, .qr]
    }
    
    func convertToMetadataType() -> BarcodeType {
        switch self {
        case .code39:
            return .code39
        case .code39Mod43:
            return .code39Mod43
        case .code93:
            return .code93
        case .code128:
            return .code128
        case .ean8:
            return .ean8
        case .ean13:
            return .ean13
        case .interleaved2of5:
            return .interleaved2of5
        case .itf14:
            return .itf14
        case .upce:
            return .upce
        case .aztec:
            return .aztec
        case .dataMatrix:
            return .dataMatrix
        case .pdf417:
            return .pdf417
        case .qr:
            return .qr
        default:
            return .none
        }
    }
    
}
