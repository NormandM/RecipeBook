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
    @GestureState var scale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .leading) {
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
                
                Text("Ingredients")
                ScrollView {
                    Text(recipe.wrappedIngredientf)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .border(Color.black, width: 1)

                }
                .background(Color.red)
                Text("Preparation")
                ScrollView {
                    Text(recipe.wrappedPreparation)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .border(Color.black, width: 1)
                }
                .background(Color.blue)
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            .navigationBarTitle(recipe.wrappedName, displayMode: .inline)
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
        RecipeDetail()
    }
}
