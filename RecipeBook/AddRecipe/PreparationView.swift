//
//  PreparationView.swift
//  RecipeForm
//
//  Created by Normand Martin on 2020-07-29.
//

import SwiftUI

@available(iOS 14.0, *)
struct PreparationView: View {
    @Binding var preparation: String
    @Environment(\.presentationMode) var presentationMode
    @State private var recipePreparation: String = ""
    @State private var recognizedText = ""
    @State private var scaningPreparation = false
    @State private var showingScanningView = false
    @StateObject private var keyboardHandler = KeyboardHandler()
    var body: some View {
        GeometryReader { geo in
        VStack {
            Spacer()
            ZStack {
                ColorReference.specialSand
                    .edgesIgnoringSafeArea(.all)
                TextEditor( text: scaningPreparation ? $recognizedText : $recipePreparation)
                    .border(Color.black, width: 1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                
                if keyboardHandler.keyboardHeight == 0 && recipePreparation == "" && recognizedText == ""{
                Text("Scan with Camera\n\n\nOr\n\n\nType Preparation directly")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .font(.title)

                }
                
                
            }
                HStack {
                    Button(action: {
                        self.showingScanningView = true
                        scaningPreparation = true
                    }, label: {
                        Label(title: {
                            Text("Scan")
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
        .navigationBarTitle("Preparation", displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
          Button(action: {
            if scaningPreparation {
                self.preparation = recognizedText
            }else{
                self.preparation = recipePreparation
            }
            self.presentationMode.wrappedValue.dismiss()
          }) {
            HStack {
              Image(systemName: "chevron.left")
              Text("Back")
            }
        })
        
//        .navigationBarItems(trailing:
//            Button(action: {
//            if scaningPreparation {
//                self.preparation = recognizedText
//            }else{
//                self.preparation = recipePreparation
//            }
//            UIApplication.shared.endEditing()
//            }
//            , label: {
//            Text("Save")
//            })
//            .padding()
//        )
                                
        .sheet(isPresented: $showingScanningView) {
            ScanDocumentView(recognizedText: self.$recognizedText)
        }
        }
}
}

@available(iOS 14.0, *)
struct PreparationView_Previews: PreviewProvider {
    static var previews: some View {
        PreparationView(preparation: .constant(""))
    }
}
