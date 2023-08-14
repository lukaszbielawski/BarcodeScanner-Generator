//
//  BarcodeGeneratorView.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 11/08/2023.
//

import SwiftUI

struct BarcodeGeneratorView: View {
    
    var type: BarcodeType
    @StateObject var vm = BarcodeGeneratorViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            TopPopupView(isTriggered: $vm.isErrorPopupShown, text: "Error occurred", systemImage: "exclamationmark.triangle.fill", color: .systemRed)
                .zIndex(5)
            TopPopupView(isTriggered: $vm.isSavedPopupShown, text: "Image saved", systemImage: "cloud.fill", color: .accentColor)
                .zIndex(5)
            VStack{
                
                Text("Generate \(type.rawValue)")
                    .font(.title)
                    .foregroundColor(Color(uiColor: .secondaryColor))
                Divider()
                GeometryReader { geo in
                    VStack {
                        HStack {
                            Spacer()
                            if let image = vm.image{
                                Image(uiImage: image)
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 100)
                            }
                            Spacer()
                        }
                        Button(action: {
                            vm.imageSaver!.writeToPhotoAlbum(image: vm.image!) }
                        ) {
                            Label("Store in photo album", systemImage: "square.and.arrow.down.fill")
                        }.buttonStyle(.borderedProminent)
                            .padding(.vertical)
                            .opacity(vm.image == nil ? 0.0 : 1.0)
                        
                    }
                    .frame(maxHeight: geo.size.height)
                }
                Divider()
                BarcodeGeneratorFormView(type: type, vm: vm)
            }
            .alert(vm.error?.errorDescription ?? "null", isPresented: $vm.showMessageLengthAlert) {
                Button("OK") {}
            }
            .background(Color(uiColor: .formColor))
            .tint(Color(uiColor: .accentColor))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {dismiss()}) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
//            Label("Back", systemImage: "chevron.left")
        })
    }
}

struct BarcodeGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeGeneratorView(type: .aztec)
    }
}
