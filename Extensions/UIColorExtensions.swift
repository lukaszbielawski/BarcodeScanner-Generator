//
//  ColorExtensions.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 10/08/2023.
//

import Foundation
import SwiftUI

extension UIColor {
    static let primaryColor: UIColor = {
        UIColor(named: "PrimaryColor")!
    }()
    
    static let secondaryColor: UIColor = {
        UIColor(named: "SecondaryColor")!
    }()
    
    static let accentColor: UIColor = {
        UIColor(named: "AccentColor")!
    }()
    
    static let formColor: UIColor = {
        UIColor(named: "FormColor")!
    }()
    
    static var randomLightColor: UIColor {
        return UIColor(red: CGFloat.random(in: 0.50...0.9), green: CGFloat.random(in: 0.50...0.9), blue: CGFloat.random(in: 0.50...0.9), alpha: 1.0)
    }
    
    static var randomDarkColor: UIColor {
        return UIColor(red: CGFloat.random(in: 0.1...0.39), green: CGFloat.random(in: 0.1...0.39), blue: CGFloat.random(in: 0.1...0.39), alpha: 1.0)
    }

}
