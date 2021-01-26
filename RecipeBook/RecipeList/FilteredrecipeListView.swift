//
//  FilteredrecipeListView.swift
//  RecipeBook
//
//  Created by NORMAND MARTIN on 2020-08-22.
//

import SwiftUI

struct FilteredrecipeListView: View {
    var fetchRequestRecipe: FetchRequest<Recipe>
    init(filter: String){
        fetchRequestRecipe = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [],predicate: NSPredicate(format: "type == %@", filter))
    }
    var body: some View {
        
            ForEach(fetchRequestRecipe.wrappedValue){recipe in
                NavigationLink(destination: RecipeDetail(recipe: recipe, isSheetShown: false)) {
                    Text(recipe.wrappedName)
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
