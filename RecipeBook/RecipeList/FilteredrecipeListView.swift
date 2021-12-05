//
//  FilteredrecipeListView.swift
//  RecipeBook
//
//  Created by NORMAND MARTIN on 2020-08-22.
//

import SwiftUI

struct FilteredrecipeListView: View {
    @Environment(\.colorScheme) var colorScheme
    var fetchRequestRecipe: FetchRequest<Recipe>
    init(filter: String){
        fetchRequestRecipe = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [],predicate: NSPredicate(format: "type == %@", filter))
    }
    
    var body: some View {
            ForEach(fetchRequestRecipe.wrappedValue, id: \.self){recipe in
                NavigationLink(destination: RecipeDetail(recipe: recipe)) {
                    Text(NSLocalizedStringFunc(key:recipe.wrappedName))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .padding(.leading)
                }
            }
            .onAppear{
                print(colorScheme)
            }
            Text("")
            
            
                .listRowBackground(ColorReference.specialCoral)
    }
}

//struct FilteredrecipeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredrecipeListView(filter: "")
//    }
//}
