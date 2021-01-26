//
//  PdfSizeReduction.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-12-31.
//

import Foundation
import UIKit
import PDFKit

struct PDFSizeReduction {
    static func execute(pdfData: Data) -> Data{
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let pdfDataUrl = documentDirectory.appendingPathComponent("pdfData")
    do{
        try pdfData.write(to: pdfDataUrl)
    }catch(let error){
        print("error is \(error.localizedDescription)")
    }
    guard let uIImage = PdfToUIImage.drawPDFfromURL(url: pdfDataUrl), let newData = uIImage.jpeg(.low), let newUIImage = UIImage(data: newData), let newPDfPage = PDFPage(image: newUIImage) else {
        return Data()
    }
    let newPDF = PDFDocument()
    newPDF.insert(newPDfPage, at: 0)
        guard let trimmedData = newPDF.dataRepresentation() else {
            return Data()
        }
    return trimmedData
    }
}
