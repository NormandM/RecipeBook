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
        
            ForEach(fetchRequestRecipe.wrappedValue){recipe in
                NavigationLink(destination: RecipeDetail(recipe: recipe)) {
                    Text(recipe.wrappedName)
                        .foregroundColor(colorScheme == .light ? .black : .black)
                        .padding(.leading)
                }
            }
            .listRowBackground(ColorReference.specialSand)
    }
}

//struct FilteredrecipeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredrecipeListView(filter: "")
//    }
//}
