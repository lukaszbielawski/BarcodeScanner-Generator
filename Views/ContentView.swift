//
//  ContentView.swift
//  BarcodeScanner-Generator
//
//  Created by Łukasz Bielawski on 14/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                ScannerView()
                    .tabItem {
                        Label("Scan", systemImage: "barcode.viewfinder")
                    }
                GenerateView()
                    .tabItem {
                        Label("Generate", systemImage: "qrcode")
                    }
        }.onAppear {
            UITabBar.appearance().backgroundColor = .primaryColor
        }
   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
