//
//  BarcodeGeneratorFormView.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 12/08/2023.
//

import SwiftUI

struct BarcodeGeneratorFormView: View {
    
    var type: BarcodeType
    @ObservedObject var vm: BarcodeGeneratorViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Section {
                FormFieldView {
                    TextField("Message", text: $vm.formModel.message)
                        .autocorrectionDisabled(true)
                }
            } header: {
                FieldHeaderTextView(text: "\(type.rawValue) settings")
            }
            Section {
                FormFieldView {
                    if !type.isBarcode {
                        
                        if type == .qr {
                            QRPickerView(correctionLevel: $vm.formModel.correctionLevel)
                        } else {
                            Slider(value: $vm.formModel.correctionLevel, in: type.correctionLevels, step: 1.0)
                        }
                        
                    } else {
                        Slider(value: $vm.formModel.barcodeHeight, in: 5.0...1000.0, step: 5.0)
                    }
                }
            } header: {
                FieldHeaderTextView(text: {
                    switch type {
                    case .qr:
                        return "Correction level"
                    case .code128:
                        return "Barcode height: \(Int(vm.formModel.barcodeHeight))"
                    default:
                        return "Correction level: \(Int(vm.formModel.correctionLevel))"
                    }
                }()
                )
                
                
                
                
            }
            FormFieldView {
                Button {
                    switch type {
                    case .aztec:
                        vm.generateAztecImage(from: vm.formModel.message, correctionLevel: vm.formModel.correctionLevel)
                        
                    case .code128:
                        vm.generateCode128Image(from: vm.formModel.message, barcodeHeight: vm.formModel.barcodeHeight)
                        
                    case .pdf417:
                        vm.generatePDF417Image(from: vm.formModel.message, correctionLevel: vm.formModel.correctionLevel)
                        
                    default:
                        vm.generateQRImage(message: vm.formModel.message, correctionLevel: vm.formModel.correctionLevel)
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Generate")
                        Spacer()
                    }
                }
            }.padding(.bottom)
        }.background(Color(uiColor: .formColor))
            .onAppear {
                vm.formModel.correctionLevel = type == .aztec ? 5.0 : 0.0
            }
    }
}

private extension BarcodeGeneratorFormView {
    struct FieldBackgroundView: View {
        var body: some View {
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                .frame(minHeight: 50)
                .foregroundColor(Color(uiColor: .primaryColor))
        }
    }
    
    struct FieldHeaderTextView: View {
        var text: String
        
        var body: some View {
            Text(text)
                .foregroundColor(Color(uiColor: .secondaryColor))
                .textCase(.uppercase)
                .font(.footnote)
                .padding(.leading, 12)
        }
    }
    
    struct QRPickerView: View {
        
        @Binding var correctionLevel: Double
        
        var body: some View {
            Picker("", selection: $correctionLevel) {
                Text("L")
                    .tag(0.0)
                Text("M")
                    .tag(1.0)
                Text("Q")
                    .tag(2.0)
                Text("H")
                    .tag(3.0)
            }.pickerStyle(.segmented)
        }
    }
    
    struct FormFieldView<Content: View>: View {
        @ViewBuilder let contentView: Content
        
        var body: some View {
            contentView
                .padding(10)
                .background(BarcodeGeneratorFormView.FieldBackgroundView())
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
        }
    }
}

struct BarcodeGeneratorFormView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeGeneratorFormView(type: .aztec, vm: BarcodeGeneratorViewModel())
        BarcodeGeneratorFormView(type: .qr, vm: BarcodeGeneratorViewModel())
    }
}
