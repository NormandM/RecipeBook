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
    @State private var recipePreparation: String = ""
    @State private var recognizedText = ""
    @State private var scaningPreparation = false
    @State private var showingScanningView = false
    @StateObject private var keyboardHandler = KeyboardHandler()
    var body: some View {
        
        VStack {
            ZStack {
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
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    if scaningPreparation {
                        self.preparation = recognizedText
                    }else{
                        self.preparation = recipePreparation
                    }
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Save")
                })
                .padding()
            }
            ToolbarItem(placement: .bottomBar){
                Button(action: {
                    self.showingScanningView = true
                    scaningPreparation = true
                }, label: {
                    Label("", systemImage: "camera.fill")
                })
                .padding()
            }
            ToolbarItem(placement: .bottomBar){
                Button(action: {
                }, label: {
                    Label("", systemImage: "square.and.pencil")
                })
                .padding()
            }
        }
        .navigationBarTitle("Preparation", displayMode: .inline)
        .sheet(isPresented: $showingScanningView) {
            ScanDocumentView(recognizedText: self.$recognizedText)
        }
    }
}

@available(iOS 14.0, *)
struct PreparationView_Previews: PreviewProvider {
    static var previews: some View {
        PreparationView(preparation: .constant(""))
    }
}
