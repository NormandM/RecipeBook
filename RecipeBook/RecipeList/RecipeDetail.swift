//
//  RecipeDetail.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-09.
//

import SwiftUI

struct RecipeDetail: View {
    @State private var image: Image?
    var recipe = FetchedResults<Recipe>.Element()
    @State var isSheetShown: Bool = false
    @State private var isGeneralInformationShown = false
    @State private var isNutrionFactsShown = false
    @GestureState var scale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .center) {
                Text(recipe.wrappedName)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                HStack {
                    VStack{
                        Button(action: {
                            isGeneralInformationShown = true
                        }){
                            VStack  {
                                Image(systemName: "info.circle")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                Text("General")
                                Text("Information")
                            }
                        }
                        .sheet(isPresented: $isGeneralInformationShown){
                            GeneralInformationView()
                        }
                        
                    }
                    if let unwrappedImage = image {
                        unwrappedImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .border(Color.black, width: 1)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .padding(.top)
                            .scaleEffect(scale)
                            .gesture(MagnificationGesture()
                                    .updating($scale, body: { (value, scale, trans) in
                                        scale = value.magnitude
                                    })
                            )
                            .zIndex(1)
                    }else{
                        Image("LEARNFROMTIMELINE")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .border(Color.black, width: 1)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .padding(.top)

                    }
                    VStack{
                        Button(action: {
                            isNutrionFactsShown = true
                        }){
                            VStack  {
                                Image(systemName: "info.circle")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                Text("Nutrition")
                                Text("Facts")
                            }
                        }
                        .sheet(isPresented: $isNutrionFactsShown){
                            NutritionInformationView()
                        }
                    }
                    
                }

                
                Text("Ingredients")
                ScrollView {
                    Text(recipe.wrappedIngredientf)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                        .border(Color.black, width: 1)

                }
                .background(ColorReference.specialCoral)
                Text("Preparation")
                ScrollView {
                    Text(recipe.wrappedPreparation)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                        .border(Color.black, width: 1)
                }
                .background(ColorReference.specialGray)
            }
            .padding()
            .navigationBarItems(trailing:
                                    Button(action: {
                                        
                                    }) {
                                        Text("Edit")
                                    })
            .padding()
            .background(ColorReference.specialSand)
            .navigationBarColor(UIColorReference.specialGreen)
            .navigationBarTitle("Recipe", displayMode: .inline)
            .onAppear{
                guard let uiImage = UIImage(data: recipe.wrappedPhoto as Data) else { return }
                image = Image(uiImage: uiImage)
                
            }
            
        }
            
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    var recipe = FetchedResults<Recipe>.Element()
    static var previews: some View {
        RecipeDetail(isSheetShown: false)
    }
}
