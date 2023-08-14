//
//  TopPopupView.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 10/08/2023.
//

import SwiftUI

struct TopPopupView: View {
    @Binding var isTriggered: Bool
    
    var text: String
    var systemImage: String
    var color: UIColor
    
    var body: some View {
        GeometryReader { gr in
            if isTriggered {
                    Label(text, systemImage: systemImage)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color(uiColor: color).cornerRadius(16.0))
                        .position(x: gr.frame(in: .local).width * 0.5)
                        .transition(.move(edge: .top))
                        .padding(.vertical, 32)
                        .animation(Animation.easeInOut(duration: 1.0))
            }
        }
    }
}

struct TopPopupView_Previews: PreviewProvider {
    static var previews: some View {
        TopPopupView(isTriggered: .constant(true), text: "Copied", systemImage: "doc.on.clipboard.fill", color: .accentColor)
            .previewLayout(.sizeThatFits)
    }
}
