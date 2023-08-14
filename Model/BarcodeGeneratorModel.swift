//
//  BarcodeGeneratorModel.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 13/08/2023.
//

import Foundation
import SwiftUI

class FormModel: ObservableObject {
    @Published var message: String = ""
    @Published var correctionLevel: Double = 0.0
    @Published var barcodeHeight: Double = 50.0
    
}

enum GeneratorError: Error, LocalizedError {
    case toolittlechars
    case toomanychars
    
    var errorDescription: String? {
        switch self {
        case .toolittlechars:
            return "Your message is too short!"
        default:
            return "Your message is too long!"
        }
    }
}
