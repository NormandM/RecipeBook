//
//  ScanDocumentView.swift
//  Text Recognition Sample
//
//  Created by Stefan Blos on 25.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//
import SwiftUI
import VisionKit
import Vision
import PDFKit

struct ScanDocumentView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    weak var pdfDocument: PDFDocument?
    var nameOfScan: String
    func makeCoordinator() -> Coordinator {
        Coordinator(pdfDocument: pdfDocument ?? PDFDocument(), parent: self, nameOfScan: nameOfScan)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        // nothing to do here
        
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var pdfDocument: PDFDocument
        var nameOfScan: String
        var parent: ScanDocumentView
        init(pdfDocument: PDFDocument, parent: ScanDocumentView, nameOfScan: String) {
            self.pdfDocument = pdfDocument
            self.parent = parent
            self.nameOfScan = nameOfScan
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan)
            var image: CGImage?
            for i in 0 ..< scan.pageCount {
                image = extractedImages[i]
                let uiImage = UIImage(cgImage: image!)
                var lowResUIImage = UIImage()
                if let imageData = uiImage.jpeg(.lowest) {
                    lowResUIImage = UIImage(data: imageData) ?? UIImage()
                }
                let pdfPage = PDFPage(image: lowResUIImage)
                pdfDocument.insert(pdfPage!, at: i)
            }
            let data = pdfDocument.dataRepresentation()
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let docURL = documentDirectory.appendingPathComponent(nameOfScan)
            do{
              try data?.write(to: docURL)
            }catch(let error){
               print("error is \(error.localizedDescription)")
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
            for index in 0..<scan.pageCount {
                let extractedImage = scan.imageOfPage(at: index)
                guard let cgImage = extractedImage.cgImage else { continue }
                extractedImages.append(cgImage)
            }
            return extractedImages
        }
        
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
