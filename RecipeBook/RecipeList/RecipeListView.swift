//
//  RecipeListView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-09.
//

import SwiftUI

struct RecipeListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: MealType.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    
    
    var body: some View {
        List {
        ForEach(recipes){ recipe in
            NavigationLink(destination: RecipeDetail(recipe: recipe)){
                Text(recipe.wrappedName)
                    
            }
        }
        .onDelete(perform: removeRecipies)
            
        }
        .navigationBarItems(trailing:  EditButton())
        .navigationBarTitle("List of Recipies")
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
//List {
//    ForEach (name) { section in
//        Section(header: SectionRow(name: section)) {
//            ForEach(section.items) {item in
//                NavigationLink(destination: ContentView(item: item, section: section)){
//                    HStack {
//                        ItemRowView(item: item)
//                    }
//
//                }
//            }.listRowBackground(ColorReference.specialGreen)
//        }
//
//    }
//
//}
