//
//  IngredientView.swift
//  RecipeForm
//
//  Created by Normand Martin on 2020-07-29.
//
import AVFoundation
import SwiftUI
import UIKit
import Foundation

@available(iOS 14.0, *)
struct IngredientView: View {
    @Binding var ingredient: String
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var recipeIngredient: String = ""
    @State private var recognizedText = ""
    var existingIngredient: String
    @Binding var isInitialValue: Bool
    @State private var scaningIngredient = false
    @State private var showingScanningView = false
    @StateObject private var keyboardHandler = KeyboardHandler()
    var body: some View {
        GeometryReader{ geo in
            
            VStack {
                Spacer()
                ZStack {
                    ColorReference.specialSand
                        .edgesIgnoringSafeArea(.all)
                    TextEditor( text: scaningIngredient ? $recognizedText : $recipeIngredient)
                        .border(Color.black, width: 1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    if keyboardHandler.keyboardHeight == 0 && recipeIngredient == "" && recognizedText == ""{
                        Text(NSLocalizedStringFunc(key:"Scan with Camera\n\n\nOr\n\n\nWrite Ingredients directly"))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .font(.title)
                    }
                }
                HStack {
                    Button(action: {
                        self.showingScanningView = true
                        scaningIngredient = true
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
                        
                        
                    }, label: {
                        Label(title: {
                            Text(NSLocalizedStringFunc(key:"Write"))
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

            .navigationBarTitle(NSLocalizedStringFunc(key:"Ingredients"), displayMode: .inline)
            .navigationBarColor(UIColorReference.specialGreen)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
              Button(action: {
                if scaningIngredient {
                    self.ingredient = recognizedText
                }else{
                    self.ingredient = recipeIngredient
                }
                self.presentationMode.wrappedValue.dismiss()
              }) {
                HStack {
                  Image(systemName: "chevron.left")
                    Text(NSLocalizedStringFunc(key:"Back"))
                }
            })
            .sheet(isPresented: $showingScanningView) {
                ScanDocumentView(recognizedText: self.$recognizedText)
                    .environment(\.managedObjectContext, self.moc)
            }
            .onAppear {
                if existingIngredient != "" {
                    scaningIngredient = false
                    recipeIngredient = existingIngredient
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
