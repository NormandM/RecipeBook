//
//  ThreePhotoView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-11-06.
//

import SwiftUI

struct ThreePhotoView: View {
    @State private var image: Image?
    @GestureState var scale: CGFloat = 1.0
    var recipeData: Data
    var body: some View {
        VStack {
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
                Image("IconeRecipe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .border(Color.black, width: 1)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .padding(.top)
                
            }
        }
        .navigationBarTitle(NSLocalizedStringFunc(key:"Photos"), displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .background(ColorReference.specialSand)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear{
            guard let uiImage = UIImage(data: recipeData) else { return }
            image = Image(uiImage: uiImage)
        }
    }
}

struct ThreePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ThreePhotoView(recipeData: Data())
    }
}
