//
//  AddARecipe.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-28.
//

import SwiftUI

struct AddARecipe: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    @State private var data: Data?
    @State private var chef = ""
    @State private var timeToPrepare = ""
    @State private var timeToCook = ""
    @State private var ingredient = ""
    @State private var name = ""
    @State private var preparation = ""
    @State private var typeNumber = 0
    @State private var rating = 3
    @State private var servings = 2
    @State private var calcium = ""
    @State private var calories = ""
    @State private var carbohydrate = ""
    @State private var cholesterol = ""
    @State private var iron = ""
    @State private var potassium = ""
    @State private var protein = ""
    @State private var saturatedFat = ""
    @State private var sodium = ""
    @State private var totalFat = ""
    @State private var transFat = ""
    @State private var vitaminD = ""
    @State private var sugar = ""
    var body: some View {
            Form {
                Section {
                    TextField("Name of recipe", text: $name, onCommit: {
                        UIApplication.shared.endEditing()
                    })
                    
                    TextField("Name of Chef", text: $chef, onCommit: {
                        UIApplication.shared.endEditing()
                    })
                    TextField("Preparation Time", text: $timeToPrepare, onCommit: {
                        UIApplication.shared.endEditing()
                    })
                    TextField("Cooking Time", text: $timeToCook, onCommit: {
                        UIApplication.shared.endEditing()
                    })
                    
                    
                    Picker("Category: ", selection: $typeNumber){
                        ForEach(0 ..< mealTypes.count){mealtypeNo in
                            HStack {
                                Text("\(mealTypes[mealtypeNo].wrappedType)")
                                
                                Image(mealTypes[mealtypeNo].wrappedType)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50.0, height: 50.0)
                                

                            }
                            
                        }
                    }
                    RatingView(rating: $rating)
                    Picker("Servings", selection: $servings) {
                        ForEach(1..<12){
                            Text("\($0)")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: NutritionalFactsView(calcium: $calcium, calories: $calories, carbohydrate: $carbohydrate, cholesterol: $cholesterol, iron: $iron, potassium: $potassium, protein: $protein, saturatedFat: $saturatedFat, sodium: $sodium, totalFat: $totalFat, transFat: $transFat, vitaminD: $vitaminD, sugar: $sugar)){
                        Text("Nutrition Facts")
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
            .navigationBarTitle("Add a Recipe", displayMode: .inline)
            .navigationBarColor(UIColorReference.specialGreen)
            .navigationBarItems(trailing:
                Button(action: {
                    let newRecipe = Recipe(context: self.moc)
                    newRecipe.chef = self.chef
                    newRecipe.ingredient = self.ingredient
                    newRecipe.type = mealTypes[typeNumber].type
                    newRecipe.name = self.name
                    newRecipe.timeToPrepare = self.timeToPrepare
                    newRecipe.timeToCook = self.timeToCook
                    newRecipe.preparation = self.preparation
                    newRecipe.rating = Int16(self.rating)
                    newRecipe.photo = data
                    newRecipe.id = UUID()
                    newRecipe.calcium = self.calcium
                    newRecipe.calories = self.calories
                    newRecipe.carbohydrate = self.carbohydrate
                    newRecipe.cholesterol = self.cholesterol
                    newRecipe.iron = self.iron
                    newRecipe.potassium = self.potassium
                    newRecipe.protein = self.protein
                    newRecipe.saturatedFat = self.saturatedFat
                    newRecipe.sodium = self.sodium
                    newRecipe.totalFat = self.totalFat
                    newRecipe.transFat = self.transFat
                    newRecipe.vitaminD = self.vitaminD
                    newRecipe.sugar = self.sugar
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                    UIApplication.shared.endEditing()
                    
                }, label: {
                    Text("Save")
                })
                .padding()
                                
            )
    }
    
}

struct AddARecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddARecipe()
    }
}
