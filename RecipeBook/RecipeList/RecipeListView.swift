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
    @FetchRequest(entity: MealType.entity(), sortDescriptors: []) var mealTypes: FetchedResults<MealType>
    var body: some View {
        List {
            ForEach (0 ..< mealTypes.count) { number in
                Section(header: SectionRow(filter: mealTypes[number].wrappedType)) {
                    FilteredrecipeListView(filter: mealTypes[number].wrappedType)
                        .listRowBackground(ColorReference.specialSand)
                        .edgesIgnoringSafeArea(.all)
                }
                .listRowInsets(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0))
            }
            .onDelete(perform: removeRecipies)
        }
        .navigationBarItems(trailing:  EditButton())
        .navigationBarTitle("List of Recipies", displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
    }
    
    func removeRecipies(at offsets: IndexSet) {
        for index in offsets {
            let recipe = recipes[index]
            moc.delete(recipe)
        }
        try? moc.save()
    }
}


struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}


