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
    @State var pdfView = PDFView()
    var nameOfScan: String
    func makeUIView(context: Context) -> UIView {
        let docURL = documentDirectory.appendingPathComponent(nameOfScan)
        pdfView.document = PDFDocument(url: docURL)
        pdfView.autoScales = true
        return pdfView
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        let docURL = documentDirectory.appendingPathComponent(nameOfScan)
        pdfView.document = PDFDocument(url: docURL)
        pdfView.autoScales = true
    }
    
    
}
