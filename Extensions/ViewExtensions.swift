//
//  ViewExtensions.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 14/08/2023.
//

import Foundation
import SwiftUI

extension View {
    func disableSwipeBack() -> some View {
        self.background(
            DisableSwipeBackView()
        )
    }
}

struct DisableSwipeBackView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = DisableSwipeBackViewController
    
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        UIViewControllerType()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

class DisableSwipeBackViewController: UIViewController {
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if let parent = parent?.parent,
           let navigationController = parent.navigationController,
           let interactivePopGestureRecognizer = navigationController.interactivePopGestureRecognizer {
            navigationController.view.removeGestureRecognizer(interactivePopGestureRecognizer)
        }
    }
}
