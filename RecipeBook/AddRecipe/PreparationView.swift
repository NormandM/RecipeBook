//
//  PreparationView.swift
//  RecipeForm
//
//  Created by Normand Martin on 2020-07-29.
//

import SwiftUI
import PDFKit
import UIKit
@available(iOS 14.0, *)
struct PreparationView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var preparation: String
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var recipePreparation: String = ""
    @State private var recognizedText = ""
    @State private var scaningPreparation = false
    @State private var showingScanningView = false
    @State private var writingPreparation = false
    @StateObject private var keyboardHandler = KeyboardHandler()
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    @Binding var pdfPreparation: Data
    var existingPreparation: String
    var existingPreparationPdf: Data
    @State var pdfView: PdfViewUI!
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                ZStack {
                    ColorReference.specialSand
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        if scaningPreparation || existingPreparationPdf != Data() {
                            pdfView
                                
                                .border(Color.black, width: 1)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                        }
                        if writingPreparation || existingPreparation != ""{
                            TextEditor( text: $recipePreparation)
                                .border(Color.black, width: 1)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                            
                        }
                    }
                    
                    if keyboardHandler.keyboardHeight == 0 && recipePreparation == "" && recognizedText == "" && !scaningPreparation && !writingPreparation && existingPreparationPdf == Data(){
                        VStack {
                            Button(action: {
                                self.showingScanningView = true
                                scaningPreparation = true
                            }, label: {
                                HStack {
                                    Text("Scan with Camera")
                                        .multilineTextAlignment(.center)
                                        .font(.title)
                                        .foregroundColor(.blue)
                                    
                                }
                            })
                                .padding()
                            Text("or")
                                .foregroundColor(colorScheme == .light ? .black : .black)
                            Button(action: {
                                recipePreparation = ""
                                writingPreparation = true
                            }, label: {
                                HStack {
                                    Text("Write Ingredients directly")
                                        .multilineTextAlignment(.center)
                                        .font(.title)
                                        .foregroundColor(.blue)
                                }
                                
                                
                            })
                                .padding()
                        }
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            self.showingScanningView = true
                            scaningPreparation = true
                        }, label: {
                            HStack {
                                Text("Scan")
                                Image(systemName: "camera.fill")
                            }
                            .padding()
                            
                        })
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Spacer()
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            recipePreparation = ""
                            writingPreparation = true
                        }, label: {
                            HStack {
                                Text("Write")
                                Image(systemName: "square.and.pencil")
                            }
                            .padding()
                            
                        })
                    }
                }
            }
            .navigationBarTitle(NSLocalizedStringFunc(key:"Preparation"), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                                        if scaningPreparation {
                                            let docURL = documentDirectory.appendingPathComponent("Preparation.pdf")
                                            pdfPreparation =  PDFDocument(url: docURL)?.dataRepresentation() ?? Data()
                                            pdfPreparation = PDFSizeReduction.execute(pdfData: pdfPreparation)
                                            
                                        }
                                        if writingPreparation {
                                            self.preparation = recipePreparation
                                        }
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        HStack {
                                            Image(systemName: "chevron.left")
                                            Text(NSLocalizedStringFunc(key:"Back"))
                                        }
                                    })
            .sheet(isPresented: $showingScanningView, onDismiss:{
                pdfView = PdfViewUI(nameOfScan: "Preparation.pdf")
            }) {
                ScanDocumentView(nameOfScan: "Preparation.pdf")
            }
        }
        .navigationBarColor(UIColorReference.specialGreen)
        .background(ColorReference.specialSand)
        .edgesIgnoringSafeArea([.leading, .trailing])
        .onAppear{
            if existingPreparation != "" {
                writingPreparation = true
                recipePreparation = existingPreparation
            }
            if existingPreparationPdf != Data() {
                scaningPreparation = true
                let data = existingPreparationPdf
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let docURL = documentDirectory.appendingPathComponent("Preparation.pdf")
                do{
                    try data.write(to: docURL)
                }catch(let error){
                    print("error is \(error.localizedDescription)")
                }
                pdfView = PdfViewUI(nameOfScan: "Preparation.pdf")
            }
        }
    }
    
}

//@available(iOS 14.0, *)
//struct PreparationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreparationView(preparation: .constant(""), existingPreparation: "", pdfView: <#PdfViewUI#>)
//    }
//}
