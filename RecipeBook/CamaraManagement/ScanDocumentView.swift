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
    @Binding var update: String
    @Environment(\.presentationMode) var presentationMode
    var pdfDocument = PDFDocument()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(pdfDocument: pdfDocument, parent: self)
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
        var parent: ScanDocumentView
        init(pdfDocument: PDFDocument, parent: ScanDocumentView) {
            self.pdfDocument = pdfDocument
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
          //  let pdfDocument2 = PDFDocument()
            let extractedImages = extractImages(from: scan)
            var image: CGImage?
            for i in 0 ..< scan.pageCount {
                image = extractedImages[i]
                let pdfPage = PDFPage(image: UIImage(cgImage: image!))
                  pdfDocument.insert(pdfPage!, at: i)
            }
            let data = pdfDocument.dataRepresentation()
                        
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        
            let docURL = documentDirectory.appendingPathComponent("Preparation.pdf")
                        
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
