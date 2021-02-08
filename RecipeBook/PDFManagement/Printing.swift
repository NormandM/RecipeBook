//
//  Prenting.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-12-18.
//

import Foundation
import SwiftUI
import UIKit
import PDFKit

struct PrintDocument: UIViewControllerRepresentable {
    let ingredientData: Data
    let preparationData: Data
    let imageRecipe: UIImage
    let recipeName: String
    let servings: String
    let preparationtime: String
    let cookingTime: String
    let preparationText: String
    var ingredientText: String
    let ingredientPDfIsPresent: Bool
    let preparationPDFIsPresent: Bool
    @Binding var activityMonitorIsShowing: Bool


    func makeUIViewController(context: Context) -> UIActivityViewController {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let ingredientURL = documentDirectory.appendingPathComponent("ingredients")
        let preparationURL = documentDirectory.appendingPathComponent("preparation")
        do{
            try ingredientData.write(to: ingredientURL)
        }catch(let error){
            print("error is \(error.localizedDescription)")
        }
        do{
            try preparationData.write(to: preparationURL)
        }catch(let error){
            print("error is \(error.localizedDescription)")
        }
        let servingInt = NSLocalizedStringFunc(key: "Servings")
        let preparationTimeInt = NSLocalizedStringFunc(key: "Preparation Time")
        let cookingTimeInt = NSLocalizedStringFunc(key: "Cooking Time")
        let imageNote = """
        \(servingInt): \(servings)
        \(preparationTimeInt): \(preparationtime)
        \(cookingTimeInt): \(cookingTime)
     """
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
            let img = renderer.image { ctx in
                let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
                ctx.cgContext.setFillColor(UIColor.clear.cgColor)
                ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
                ctx.cgContext.setLineWidth(1)
                ctx.cgContext.addRect(rectangle)
                ctx.cgContext.drawPath(using: .fillStroke)
            }
        let pdfPreparationImage = PdfToUIImage.drawPDFfromURL(url: preparationURL) ?? UIImage()
        let pdfIngredientUIImage = PdfToUIImage.drawPDFfromURL(url: ingredientURL) ?? UIImage()
        let pdfCreatorIngredient = PDFCreator(title: NSLocalizedStringFunc(key:"Ingredients"), body: ingredientText, image: pdfIngredientUIImage, pDfIsPresent: ingredientPDfIsPresent, rectImage: img)
        let pdfCreatorPreparation = PDFCreator(title: NSLocalizedStringFunc(key:"Preparation"), body: preparationText, image: pdfPreparationImage,  pDfIsPresent: preparationPDFIsPresent, rectImage: img)
        let pdfCreatorTRecipeImage = PDFCreator(title: recipeName, body: imageNote, image: imageRecipe, pDfIsPresent: true, rectImage: img)
        

        
        var pdfDataRecipeImage = pdfCreatorTRecipeImage.createFlyer()
        var pdfDataIngredient = pdfCreatorIngredient.createFlyer()
        var pdfDataPreparation = pdfCreatorPreparation.createFlyer()
        
        pdfDataRecipeImage = PDFSizeReduction.execute(pdfData: pdfDataRecipeImage)
        pdfDataIngredient = PDFSizeReduction.execute(pdfData: pdfDataIngredient)
        pdfDataPreparation = PDFSizeReduction.execute(pdfData: pdfDataPreparation)
        
        let pdfRecipe = PDFDocument(data: pdfDataRecipeImage)
        let pdfIngredient = PDFDocument(data: pdfDataIngredient)
        let pdfPreparation = PDFDocument(data: pdfDataPreparation)
        let pdfDocument = PDFDocument()
        
        if let pdf = pdfRecipe, let pdf2 = pdfIngredient, let pdf3 = pdfPreparation {
            pdfDocument.addPages(from: pdf)
            pdfDocument.addPages(from: pdf2)
            pdfDocument.addPages(from: pdf3)
        }
        let pdfData = pdfDocument.dataRepresentation()
        var pdfFinalDocument = Data()
        if let pdfFinal = pdfData {
            pdfFinalDocument = pdfFinal
        }
        
        if pdfFinalDocument == Data() {
            print("There is no data")
            
        }
        
        
        let activityControler = UIActivityViewController(activityItems: [pdfFinalDocument], applicationActivities: [])
        activityControler.excludedActivityTypes = [UIActivity.ActivityType.markupAsPDF, UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.saveToCameraRoll]
        return activityControler
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
       print("end 1")
        activityMonitorIsShowing = false
    }
    
}
extension PDFDocument {
    
        func addPages(from document: PDFDocument) {
            let pageCountAddition = document.pageCount
    
            for pageIndex in 0..<pageCountAddition {
                guard let addPage = document.page(at: pageIndex) else {
                    break
                }
    
                self.insert(addPage, at: self.pageCount) // unfortunately this is very very confusing. The index is the page *after* the insertion. Every normal programmer would assume insert at self.pageCount-1
            }
        }
    
    }
