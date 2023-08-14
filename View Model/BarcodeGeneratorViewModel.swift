//
//  BarcodeGeneratorViewModel.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 11/08/2023.
//

import Foundation
import SwiftUI

class BarcodeGeneratorViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var error: GeneratorError?
    @Published var showMessageLengthAlert: Bool = false
    
    @Published var formModel = FormModel()
    
    @Published var isSavedPopupShown: Bool = false {
        didSet {
            if isSavedPopupShown {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isSavedPopupShown = false
                    }
                }
            }
        }
    }
    
    @Published var isErrorPopupShown: Bool = false {
        didSet {
            if isErrorPopupShown {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isErrorPopupShown = false
                    }
                }
            }
        }
    }
    
    var imageSaver: ImageSaver?
    
    init() {
        imageSaver = ImageSaver(vm: self)
    }
    
    func generateQRImage(message: String, correctionLevel: Double) {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(message.utf8)
        
        let letter: String = {
            switch correctionLevel {
            case 0.0: return "L"
            case 1.0: return "M"
            case 2.0: return "Q"
            default: return "H"
            }
        }()
        filter.correctionLevel = letter
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                image = UIImage(cgImage: cgimg)
            }
        }
        else {
            setError()
            self.showMessageLengthAlert = true
        }
    }
    
    func generatePDF417Image(from string: String, correctionLevel: Double) {
        let context = CIContext()
        let filter = CIFilter.pdf417BarcodeGenerator()
        filter.message = Data(string.utf8)
        filter.correctionLevel = Float(correctionLevel)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                image = UIImage(cgImage: cgimg)
            }
        }
        else {
            setError()
            self.showMessageLengthAlert = true
        }
    }
    
    func generateCode128Image(from string: String, barcodeHeight: Double) {
        let context = CIContext()
        let filter = CIFilter.code128BarcodeGenerator()
        filter.message = Data(string.utf8)
        filter.barcodeHeight = Float(barcodeHeight)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                image = UIImage(cgImage: cgimg)
            }
        }
        else {
            setError()
            self.showMessageLengthAlert = true
        }
    }
    
    func generateAztecImage(from string: String, correctionLevel: Double) {
        let context = CIContext()
        let filter = CIFilter.aztecCodeGenerator()
        filter.message = Data(string.utf8)
        filter.correctionLevel = Float(correctionLevel)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                image = UIImage(cgImage: cgimg)
            }
        }
        else {
            setError()
            self.showMessageLengthAlert = true
        }
    }
    
    func setError() {
        if formModel.message.isValidMessage == .toolittlechars {
            error = .toolittlechars
        } else {
            error = .toomanychars
        }
        showMessageLengthAlert = true
    }
    
    class ImageSaver: NSObject {
        
        internal init(vm: BarcodeGeneratorViewModel) {
            self.vm = vm
        }
        
        @ObservedObject var vm: BarcodeGeneratorViewModel
        
        func writeToPhotoAlbum(image: UIImage) {
            
            let scaledImageSize = image.size.applying(CGAffineTransform(scaleX: 2, y: 2))
            
            UIGraphicsBeginImageContext(scaledImageSize)
            let scaledContext = UIGraphicsGetCurrentContext()!
            scaledContext.interpolationQuality = .none
            image.draw(in: CGRect(origin: .zero, size: scaledImageSize))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            
            UIImageWriteToSavedPhotosAlbum(scaledImage, self, #selector(saveCompleted), nil)
        }
        
        
        
        @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if error != nil {
                vm.isErrorPopupShown = true
                print("error")
            } else {
                vm.isSavedPopupShown = true
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
                
            }
            
        }
    }
}

