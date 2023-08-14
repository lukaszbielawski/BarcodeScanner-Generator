# BarcodeScanner-Generator
 

This is a simple iOS app built using SwiftUI and AVFoundation that allows users to scan barcodes using their device's camera and generate barcodes from provided text. The app demonstrates the integration of these technologies to create a functional barcode scanner and generator.

<h2>Features</h2>

* Scan various types of barcodes, including QR codes and standard barcodes.
* Generate barcodes from user-provided text and display them on the screen.
* User-friendly interface built with SwiftUI for a modern and responsive design.
* Seamless integration with AVFoundation for camera access and barcode scanning.

<h2>Presentation</h2>

<div class="image-container"> 
  <img src="https://raw.githubusercontent.com/lukaszbielawski/BarcodeScanner-Generator/main/gifs/BarcodeScanner-Generator-1.gif?token=GHSAT0AAAAAACGI5UOTRHM65UAXZSCV35VWZG2CF5A" alt="gif" width="300" height="540">
 
  <img src="https://raw.githubusercontent.com/lukaszbielawski/BarcodeScanner-Generator/main/gifs/BarcodeScanner-Generator-2.gif?token=GHSAT0AAAAAACGI5UOSFTV2HCBVYWC43BBSZG2CH2Q" alt="gif" width="300" height="540">
</div>

<h2>Requirements</h2>

* Xcode 13.0+
* Swift 5.5+
* iOS 15.0+

<h2>Installation</h2>

1. Clone the repository:

```bash
git clone https://github.com/your-username/barcode-scanner-generator-app.git
```

2. Open the project in Xcode.
3. Build and run the app on a simulator or a physical device running iOS 15.0 or later.

<h2>Usage</h2>

<h3>Barcode Scanner</h3>

1. Launch the app on your iOS device.
2. Tap the <i>Scan</i> tab bar button.
3. Point your camera at a barcode to scan it.
4. Once the barcode is recognized, its content will be displayed on the screen.

<h3>Barcode Generator</h3>

1. Launch the app on your iOS device.
2. Tap the <i>Generate</i> tab bar button.
3. Enter the message that you want to encode into a barcode.
4. Select the desired correction level for 2D barcodes and barcode height for Code 128
5. Press the <i>Generate</i> button.
6. The generated barcode will be displayed on the screen.
7. You can save it in photo album by clicking <i>Store in photo album</i> button.

<h2>License</h2>

<a href="https://www.mit.edu/~amini/LICENSE.md">MIT License</a>





