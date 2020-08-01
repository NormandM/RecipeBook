//
//  IngredientView.swift
//  RecipeForm
//
//  Created by Normand Martin on 2020-07-29.
//

import SwiftUI

@available(iOS 14.0, *)
struct IngredientView: View {
    @State private var recipeIngredient: String = ""
    @State private var recognizedText = ""
    @State private var scaningIngredient = false
    @State private var showingScanningView = false
    @StateObject private var keyboardHandler = KeyboardHandler()
    var body: some View {
        VStack {
            ZStack {
                TextEditor( text: scaningIngredient ? $recognizedText : $recipeIngredient)
                    .border(Color.black, width: 1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                if keyboardHandler.keyboardHeight == 0 && recipeIngredient == "" && recognizedText == ""{
                Text("Scan with Camera\n\n\nOr\n\n\nType Ingredients directly")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .font(.title)
                }
                
            }

        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                
                Button(action: {
                    UIApplication.shared.endEditing()
                    
                }, label: {
                    Text("Save")
                })
                .padding()
            }
            ToolbarItem(placement: .bottomBar){
                Button(action: {
                    self.showingScanningView = true
                    scaningIngredient = true
                }, label: {
                    Label("", systemImage: "camera.fill")
                })
                .padding()
            }
            ToolbarItem(placement: .bottomBar){
                Button(action: {
                }, label: {
                    Label("", systemImage: "square.and.pen")
                })
                .padding()
            }
        }
        .navigationBarTitle("Ingredients", displayMode: .inline)
        .sheet(isPresented: $showingScanningView) {
            ScanDocumentView(recognizedText: self.$recognizedText)
        }
    }
}

@available(iOS 14.0, *)
struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}
