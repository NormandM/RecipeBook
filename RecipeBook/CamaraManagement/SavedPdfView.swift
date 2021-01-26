//
//  SavedPdfView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-12-15.
//

import UIKit
import SwiftUI
import PDFKit

struct SavedPdfViewUI: UIViewRepresentable {
    var fetchRequest: FetchRequest<Recipe>
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var title: String
    var nameOfScan: String
    init(filter: String, nameOfScan: String) {
        self.fetchRequest = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
        self.title = filter
        self.nameOfScan = nameOfScan
    }
    @State var savedPdfView = PDFView()
    func makeUIView(context: Context) -> UIView {
        var preparationData = Data()
        var ingredientsData = Data()
        for item in fetchRequest.wrappedValue {
                preparationData = item.wrappedPdfPreparation
                ingredientsData = item.wrappedPdfIngredient
        }
        if nameOfScan == "Preparation.pdf"{
            savedPdfView.document = PDFDocument(data: preparationData)
        }else{
            savedPdfView.document = PDFDocument(data: ingredientsData)
        }
        savedPdfView.autoScales = true
        return savedPdfView
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    
}
