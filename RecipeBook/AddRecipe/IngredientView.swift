//
//  IngredientView.swift
//  RecipeForm
//
//  Created by Normand Martin on 2020-07-29.
//

import SwiftUI
import PDFKit

@available(iOS 14.0, *)
struct IngredientView: View {
    @Binding var ingredient: String
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var recipeIngredient: String = ""
    @State private var recognizedText = ""
    @State private var scaningIngredient = false
    @State private var showingScanningView = false
    @State private var writingIngredient = false
    @StateObject private var keyboardHandler = KeyboardHandler()
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    @Binding var pdfIngredient: Data
    var existingIngredient: String
    var existingIngredientPdf: Data
    @State var pdfView: PdfViewUI!
    var body: some View {
        GeometryReader{ geo in
            VStack {
                Spacer()
                ZStack {
                    ColorReference.specialSand
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        if scaningIngredient || existingIngredientPdf != Data() {
                            pdfView
                                .border(Color.black, width: 1)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                        }
                        if writingIngredient || existingIngredient != ""{
                            TextEditor( text: $recipeIngredient)
                                .border(Color.black, width: 1)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                        }
                    }
                    if keyboardHandler.keyboardHeight == 0 && recipeIngredient == "" && recognizedText == "" && !scaningIngredient && !writingIngredient && existingIngredientPdf == Data(){
                        Text(NSLocalizedStringFunc(key:"Scan with Camera\n\n\nOr\n\n\nWrite Ingredients directly"))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .font(.title)
                    }
                }
                .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button(action: {
                                self.showingScanningView = true
                                scaningIngredient = true
                            }, label: {
//                                Label("Scan", systemImage: "camera.fill")
//                                    .labelStyle(TitleOnlyLabelStyle())
                                HStack {
                                    Text("Scan")
                                    Image(systemName: "camera.fill")
                                }
                                    
                                })
                        }
                    
                        ToolbarItem(placement: .bottomBar) {
                            Spacer()
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button(action: {
                                recipeIngredient = ""
                                writingIngredient = true
                            }, label: {
//                                Label("Write", systemImage: "square.and.pencil")
//                                    .labelStyle(TitleOnlyLabelStyle())
                                HStack {
                                    Text("Write")
                                    Image(systemName: "square.and.pencil")
                                }
                                    
                                })
                        }
                  
                }
            }
            .navigationBarTitle(NSLocalizedStringFunc(key:"Ingredients"), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                                        if scaningIngredient {
                                            let docURL = documentDirectory.appendingPathComponent("Ingredient.pdf")
                                            pdfIngredient =  PDFDocument(url: docURL)?.dataRepresentation() ?? Data()
                                        }
                                        if writingIngredient {
                                            self.ingredient = recipeIngredient
                                        }
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        HStack {
                                            Image(systemName: "chevron.left")
                                            Text(NSLocalizedStringFunc(key:"Back"))
                                        }
                                    })
            .sheet(isPresented: $showingScanningView, onDismiss:{
                pdfView = PdfViewUI(nameOfScan: "Ingredient.pdf")
            }){
                ScanDocumentView(nameOfScan: "Ingredient.pdf")
            }
            
            .navigationBarColor(UIColorReference.specialGreen)
            .background(ColorReference.specialSand)
            .edgesIgnoringSafeArea([.leading, .trailing])
            .onAppear {
                if existingIngredient != "" {
                    writingIngredient = true
                    recipeIngredient = existingIngredient
                }
                if existingIngredientPdf != Data() {
                    scaningIngredient = true
                    let data = existingIngredientPdf
                    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let docURL = documentDirectory.appendingPathComponent("Ingredient.pdf")
                    do{
                      try data.write(to: docURL)
                    }catch(let error){
                       print("error is \(error.localizedDescription)")
                    }
                    pdfView = PdfViewUI(nameOfScan: "Ingredient.pdf")
                }
            }
            
        }
    }
}

//@available(iOS 14.0, *)
//struct IngredientView_Previews: PreviewProvider {
//    static var previews: some View {
//       IngredientView(ingredient: .constant(""), existingIngredient: "")
//    }
//}
