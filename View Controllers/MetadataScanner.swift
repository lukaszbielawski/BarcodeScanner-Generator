//
//  MetadataScanner.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 09/08/2023.
//

import SwiftUI
import UIKit
import AVFoundation

struct MetadataScanner: UIViewControllerRepresentable {
    @EnvironmentObject var scanResult: ScanResult
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = MetadataScannerController()
        controller.delegate = context.coordinator
        context.coordinator.vc = controller
        return controller
    }
    
    func makeCoordinator() -> MetadataCoordinator {
        MetadataCoordinator(scanResult: _scanResult)
    }
    
}

class MetadataScannerController: UIViewController {
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var metadataObjectFrameView: UIView?

    weak var delegate: AVCaptureMetadataOutputObjectsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Couldn't get capture device")
            return
        }
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(deviceInput)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.metadataObjectTypes = AVMetadataObject.ObjectType.allCases
            captureMetadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)

            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            metadataObjectFrameView = UIView()
            
        } catch {
            print(error)
        }
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.global(qos: .background).async {
            self.captureSession.stopRunning()
        }
    }
}



class MetadataCoordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    internal init(scanResult: EnvironmentObject<ScanResult>) {
        self._scanResult = scanResult
    }
    
    @EnvironmentObject var scanResult: ScanResult
    weak var vc: MetadataScannerController?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.isEmpty {
            self.vc?.metadataObjectFrameView?.layer.opacity = 0.0
            return
    
        }
        
        let metadataObject = metadataObjects.first! as! AVMetadataMachineReadableCodeObject
        if let vc {
            let barCodeObject = vc.videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
            
            if let metadataObjectFrameView = vc.metadataObjectFrameView {
                UIView.animate(withDuration: 0.5) {
                    metadataObjectFrameView.frame = barCodeObject!.bounds
                    metadataObjectFrameView.frame.size.width = barCodeObject!.bounds.size.width * 1.1
                    metadataObjectFrameView.frame.size.height = barCodeObject!.bounds.size.height * 1.1
                    metadataObjectFrameView.center = CGPoint(x: barCodeObject!.bounds.midX, y: barCodeObject!.bounds.midY)
                }
                metadataObjectFrameView.layer.opacity = 1.0
                metadataObjectFrameView.layer.borderColor = UIColor.green.cgColor
                metadataObjectFrameView.layer.borderWidth = 2
                vc.view.addSubview(metadataObjectFrameView)
                vc.view.bringSubviewToFront(metadataObjectFrameView)
            }
        }
        DispatchQueue.main.async {
            self.scanResult.text = "\(metadataObject.stringValue!)"
            self.scanResult.metadataType = metadataObject.type.convertToMetadataType()
        }
    }
}
