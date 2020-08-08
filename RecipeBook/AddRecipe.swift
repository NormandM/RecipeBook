//
//  AddRecipe.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-07-31.
//

import SwiftUI

struct AddRecipe: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @State private var data: Data?
    @State private var chef = ""
    @State private var ingredient = ""
    @State private var name = ""
   
    @State private var preparation = ""
    @State private var type = ""
    @State private var rating = 3
    @State private var servings = 2
    let types = ["Breakfast", "Soupes", "Salads", "Poultry", "Fish", "Meat", "Vegetables", "Appetizers", "Sauces", "Pasta", "Casseroles", "Desserts", "Bakery", "Other"]
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Name of recipe", text: $name)
                    TextField("Name of Chef", text: $chef)
                    Picker("Type of recipe", selection: $type){
                        ForEach(types, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                    Picker("Rating", selection: $rating) {
                        ForEach(0..<6) {
                            Text("\($0)")
                        }
                    }
                }
                Section {
                    Picker("Servings", selection: $servings) {
                        ForEach(1..<12){
                            Text("\($0)")
                        }
                    }
                }
                NavigationLink(destination: IngredientView(ingredient: $ingredient)){
                    Text("Ingredients")
                }.buttonStyle(PlainButtonStyle())
                NavigationLink(destination: PreparationView(preparation: $preparation)){
                    Text("Preparation")
                }
                NavigationLink(destination: PhotoView(data: $data)){
                    Text("Photo")
                }
                Section {
                    Button("Save") {
                        let newRecipe = Recipe(context: self.moc)
                        newRecipe.chef = self.chef
                        newRecipe.ingredient = self.ingredient
                        newRecipe.name = self.name
                        newRecipe.preparation = self.preparation
                        newRecipe.rating = Int16(self.rating)
                        
                        try? self.moc.save()
                        print("ingredient:\(ingredient)")
                        self.presentationMode.wrappedValue.dismiss()

                    }
                }
            }
            .navigationTitle("Add a recipe")
                
        }
    }
}



struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe()
    }
}
