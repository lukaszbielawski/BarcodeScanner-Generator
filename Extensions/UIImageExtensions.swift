//
//  UIImageExtensions.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 11/08/2023.
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

extension UIImage {
    func applyFilter() -> UIImage {
            let beginImage = CIImage(image: self )
            let context = CIContext()
            
            let customFilter = CIFilter.colorMonochrome()
            customFilter.inputImage = beginImage
            customFilter.intensity = 1
            
            guard  let outputImage = customFilter.outputImage else { return UIImage() }
            
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let filteredImage = UIImage(cgImage: cgimg)
                return filteredImage
            }
            return UIImage()
        }
}
