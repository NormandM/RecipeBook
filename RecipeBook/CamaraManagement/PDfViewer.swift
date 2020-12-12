//
//  PDfViewer.swift
//  PDFCoreData
//
//  Created by Normand Martin on 2020-12-05.
//

import Foundation
import UIKit
import SwiftUI
import PDFKit

struct PdfViewUI: UIViewRepresentable {
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var update: String
    func makeUIView(context: Context) -> UIView {
        let pdfView = PDFView()
        print("pdfView")
        let docURL = documentDirectory.appendingPathComponent("Preparation.pdf")
        pdfView.document = PDFDocument(url: docURL)
        pdfView.autoScales = true
       // try? FileManager.default.removeItem(at: docURL)
        return pdfView
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
}
