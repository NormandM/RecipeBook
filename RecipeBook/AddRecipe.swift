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
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var keyboardHandler = KeyboardHandler()
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    @State private var data: Data?
    @State private var chef = ""
    @State private var ingredient = ""
    @State private var name = ""
    @State private var preparation = ""
    @State private var type = ""
    @State private var rating = 3
    @State private var servings = 2
    var body: some View {
        NavigationView {
            Form {
                HStack {
                TextField("Name of recipe", text: $name, onCommit: {
                    UIApplication.shared.endEditing()
                })
                    Button(action: {
                        UIApplication.shared.endEditing()
                    },label: {
                        Text("Done")
                    })
                }
                HStack {
                    TextField("Name of Chef", text: $chef, onCommit: {
                        UIApplication.shared.endEditing()
                    })
                    Button(action: {
                        UIApplication.shared.endEditing()
                    },label: {
                        Text("Done")
                    })
                }
                    Picker("Type of recipe", selection: $type){
                        ForEach(mealTypes){mealType in
                            Text(mealType.wrappedType)
                            
                        
                        }
                    }
 
                    RatingView(rating: $rating)
                    Picker("Servings", selection: $servings) {
                        ForEach(1..<12){
                            Text("\($0)")
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
            }
            .onAppear{
                print("ok")
                for mealType in mealTypes {
                    print(mealType.wrappedType)
                }
            }
            .navigationTitle("Add a recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        let newRecipe = Recipe(context: self.moc)
                        newRecipe.chef = self.chef
                        newRecipe.ingredient = self.ingredient
                        newRecipe.name = self.name
                        newRecipe.preparation = self.preparation
                        newRecipe.rating = Int16(self.rating)
                        newRecipe.photo = data
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                        UIApplication.shared.endEditing()
                        
                    }, label: {
                        Text("Save")
                    })
                    .padding()
                }
            }
                
        }
    }

 
}



struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe()
    }
}
