//
//  ThreePhotoView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-11-06.
//

import SwiftUI
import PDFKit

struct RecipeIngredientsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    var fetchRequest: FetchRequest<Recipe>
    var title: String
    var savedPdfView: SavedPdfViewUI
    @State private var IngredientsPdfPresent = Data()
    @State private var ingredientsText = ""
    @State private var isPDFPresent = true

    init(filter: String) {
        self.fetchRequest = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
        self.title = filter
        self.savedPdfView = SavedPdfViewUI(filter: filter, nameOfScan: "Ingredient.pdf")

    }
    var body: some View {
        GeometryReader { geo in
            VStack{
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(colorScheme == .light ? .black : .black)
                    .padding(.leading)
                    .padding(.trailing)
                if isPDFPresent {
                    savedPdfView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .border(Color.black, width: 1)
                        .padding()
                }
                if ingredientsText != "" {
                ScrollView {
                    Text(ingredientsText)
                        .foregroundColor(colorScheme == .light ? .black : .black)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                .border(Color.black, width: 1)
                .padding()
                }
                
            }
            .onAppear{
                for item in fetchRequest.wrappedValue {
                    ingredientsText = item.wrappedIngredient
                    IngredientsPdfPresent = item.wrappedPdfIngredient
                }
                if IngredientsPdfPresent == Data() {isPDFPresent = false}
            }
            
            
        }
        .navigationBarTitle(NSLocalizedStringFunc(key:"Ingredients"), displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .background(ColorReference.specialSand)
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct RecipeIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeIngredientsView(filter: "")
    }
}
