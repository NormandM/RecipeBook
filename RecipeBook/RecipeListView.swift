//
//  RecipeListView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-09.
//

import SwiftUI

struct RecipeListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    var body: some View {
        List(recipes, id: \.self ) { recipe in
            NavigationLink(destination: RecipeDetail(recipe: recipe)){
                Text(recipe.wrappedName)
            }
            
        }
        .navigationBarTitle("List of Recipies")
    }
}


struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
