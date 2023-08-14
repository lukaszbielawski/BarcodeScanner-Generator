//
//  GenerateView.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 10/08/2023.
//

import SwiftUI
import AVFoundation

struct GenerateView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private let columns: [GridItem] = [
        GridItem(.flexible(minimum: 50.0)),
        GridItem(.flexible(minimum: 50.0))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(AVMetadataObject.ObjectType.allCases.map({$0.convertToMetadataType()})
                        .filter({$0.isGeneratable}), id: \.self) { item in
                            NavigationLink(destination: BarcodeGeneratorView(type: item)) {
                                barcodeImage(content: item.getLogo)
                            }
                            
                        }
                        .navigationTitle("Generate")
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .padding(.bottom, 8)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

private extension GenerateView {

    func barcodeImage<Content: View>(content: Content) -> some View {
        return (content as! Image)
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, maxHeight: 50)
            .foregroundColor(Color(uiColor: .secondaryColor))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 50)
            .background(Color(uiColor: colorScheme == .dark ? .randomDarkColor : .randomLightColor).cornerRadius(16.0))
    }
}

    
    


struct EncoderView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateView()
    }
}
