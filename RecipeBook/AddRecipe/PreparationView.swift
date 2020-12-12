//
//  PreparationView.swift
//  RecipeForm
//
//  Created by Normand Martin on 2020-07-29.
//

import SwiftUI
import PDFKit

@available(iOS 14.0, *)
struct PreparationView: View {
    @Binding var preparation: String
    @Binding var pdfPreparation: Data
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var recipePreparation: String = ""
    @State private var recognizedText = ""
    @State private var scaningPreparation = false
    @State private var showingScanningView = false
    @StateObject private var keyboardHandler = KeyboardHandler()
    @State private var preparationTypedIn = false
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var existingPreparation: String
    var existingPreparationPdf: Data
   // var pdfView = PdfViewUI()
    @State private var update = ""
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                ZStack {
                    ColorReference.specialSand
                        .edgesIgnoringSafeArea(.all)
//                    Image(uiImage: drawPDFfromURL(url: documentDirectory.appendingPathComponent("Preparation.pdf")) ?? UIImage(imageLiteralResourceName: "LEARNFROMTIMELINE"))
//                              .resizable()
//                              .frame(width: 300, height: 300, alignment: .center)
                    VStack {
                        Text(update)
                        PdfViewUI(update: update)
                    }
                    
//                    if showingScanningView {
//                        HStack{
//                            pdfView
//                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.7, alignment: .center)
//                                .opacity(scaningPreparation ? 1.0 : 0.0)
//                        }
//                    }else{
//                        TextEditor( text: $recipePreparation)
//                            .border(Color.black, width: 1)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .padding()
//
//                    }
//
//                    if keyboardHandler.keyboardHeight == 0 && recipePreparation == "" && recognizedText == ""{
//                        Text(NSLocalizedStringFunc(key:"Scan with Camera\n\n\nOr\n\n\nWrite Preparation directly"))
//                            .multilineTextAlignment(.center)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                            .font(.title)
//                    }
                }
                HStack {
                    Button(action: {
                        self.showingScanningView = true
                        scaningPreparation = true
                    }, label: {
                        Label(title: {
                            Text(NSLocalizedStringFunc(key:"Scan"))
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        , icon: {Image(systemName: "camera.fill")
                            .foregroundColor(.white)
                            .font(.headline)
                        })
                    })
                    .padding()
                    Spacer()
                    Button(action: {
                        recipePreparation = ""
                        
                    }, label: {
                        Label(title: {
                            Text("Write")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        , icon: {Image(systemName: "square.and.pencil")
                            .foregroundColor(.white)
                            .font(.headline)
                        })
                        
                    })
                    .padding()                   
                }
                .frame(width: geo.size.width, height: geo.size.height * 0.1)
                .background(ColorReference.specialGray)
                .edgesIgnoringSafeArea(.all)
            }

            .navigationBarTitle(NSLocalizedStringFunc(key:"Preparation"), displayMode: .inline)
            .navigationBarColor(UIColorReference.specialGreen)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                                        if scaningPreparation {
                                            preparationTypedIn = false
                                            let docURL = documentDirectory.appendingPathComponent("Preparation.pdf")
                                            pdfPreparation =  PDFDocument(url: docURL)?.dataRepresentation() ?? Data()
                                            
                                        }else{
                                            self.preparation = recipePreparation
                                            preparationTypedIn = false
                                        }
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        HStack {
                                            Image(systemName: "chevron.left")
                                            Text(NSLocalizedStringFunc(key:"Back"))
                                        }
                                    })
            
            
            .sheet(isPresented: $showingScanningView, onDismiss:{
                print("wasdismissed")
            }) {
                ScanDocumentView(update: $update)
            }

            
        }
        .onAppear{
            print("appear")
            if existingPreparation != "" {
                scaningPreparation = false
                recipePreparation = existingPreparation
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
