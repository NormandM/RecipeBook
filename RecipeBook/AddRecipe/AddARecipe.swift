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
    var fetchRequestRecipe: FetchRequest<Recipe>
    init(filter: String){
        fetchRequestRecipe = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [],predicate: NSPredicate(format: "name == %@", filter))
    }
    @State private var data: Data?
    @State private var existingData = Data()
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
    @State private var recipeSaved = false
    @State private var showAlertSameName = false
    @State private var showAlertNoName = false
    @State private var showAlertRecipeNotSaved = false
    var body: some View {
        Form {
            //  if existingRecipeName == "" {
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
                NavigationLink(destination: NutritionalFactsView(calcium: $calcium, calories: $calories, carbohydrate: $carbohydrate, cholesterol: $cholesterol, iron: $iron, potassium: $potassium, protein: $protein, saturatedFat: $saturatedFat, sodium: $sodium, totalFat: $totalFat, transFat: $transFat, vitaminD: $vitaminD, sugar: $sugar,existingcalciumRecipe: calcium,existingCaloriesRecipe: calories, existingCarbohydrateRecipe: carbohydrate, existingCholesterolRecipe: cholesterol, existingIronRecipe: iron, existingPotassiumRecipe: potassium, existingProteinRecipe: protein, existingSaturatedFatRecipe: saturatedFat, existingSodiumRecipe: sodium, existingTotalFatRecipe: totalFat, existingTransFatRecipe: transFat, existingVitaminDRecipe: vitaminD, existingSugarRecipe: sugar)){
                    Text("Nutrition Facts")
                }
            }
            NavigationLink(destination: IngredientView(ingredient: $ingredient, existingIngredient: ingredient)){
                Text("Ingredients")
            }.buttonStyle(PlainButtonStyle())
            NavigationLink(destination: PreparationView(preparation: $preparation, existingPreparation: preparation)){
                Text("Preparation")
            }
            NavigationLink(destination: PhotoView(data: $data, existingdata: existingData)){
                Text("Photo")
            }
        }

        .onAppear{
            var arrayMealTypes = [String]()
            for meal in mealTypes {
                arrayMealTypes.append(meal.wrappedType)
            }
            for recipe in fetchRequestRecipe.wrappedValue{
                if recipe.wrappedName != "" {
                    name = recipe.wrappedName
                    chef = recipe.wrappedChef
                    timeToPrepare = recipe.wrappedTimeToPrepare
                    timeToCook = recipe.wrappedTimeToPrepare
                    typeNumber = arrayMealTypes.firstIndex(of: recipe.wrappedType) ?? 0
                    rating = Int(recipe.rating)
                    servings = Int(recipe.servings)
                    ingredient = recipe.wrappedIngredientf
                    preparation = recipe.wrappedPreparation
                    calcium = recipe.wrappedCalcium
                    calories = recipe.wrappedCalories
                    carbohydrate = recipe.wrappedCarbohydrate
                    cholesterol = recipe.wrappedCholesterol
                    iron = recipe.wrappedIron
                    potassium = recipe.wrappedPotassium
                    protein = recipe.wrappedProtein
                    saturatedFat = recipe.wrappedSaturatedFat
                    sodium = recipe.wrappedSodium
                    totalFat = recipe.wrappedTotalFat
                    transFat = recipe.wrappedTransFat
                    vitaminD = recipe.wrappedVitaminD
                    sugar = recipe.wrappedSugar
                    existingData = recipe.wrappedPhoto
                }
            }
        }

        .navigationBarTitle("Add a Recipe", displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            if !recipeSaved{
                showAlertRecipeNotSaved = true
            }
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        })
        .alert(isPresented: $showAlertRecipeNotSaved) {
            Alert(title: Text("Recipe was not saved"), message: Text("Do you want to save before leaving the page?"), primaryButton: .default(Text("Save"), action: {
                saveRecipe()
            }), secondaryButton: .default(Text("Do not save"), action: {
                self.presentationMode.wrappedValue.dismiss()
                UIApplication.shared.endEditing()
            }))
        }
        ,trailing:
            Button(action: {
                saveRecipe()
            }, label: {
                Text("Save")
            })
            .padding()
            .alert(isPresented: $showAlertSameName) {
                Alert(title: Text("Recipe Name already exists"), message: Text("Please choose another name"), dismissButton: .default(Text("Ok")))
            }
        )
        .alert(isPresented: $showAlertNoName) {
            Alert(title: Text("Recipe has no name"), message: Text("Please choose a name"), dismissButton: .default(Text("Ok")))
        }
    }
    func saveRecipe(){
        var arrayName = [String]()
        for recipe in recipes {
            arrayName.append(recipe.wrappedName)
        }
        if arrayName.contains(self.name) {
            print("same")
            showAlertSameName = true
        }else if self.name == ""{
            showAlertNoName = true
        }else{
        recipeSaved = true
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
        newRecipe.servings = Int16(self.servings)
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
        UIApplication.shared.endEditing()
        }
    }
    
}

struct AddARecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddARecipe(filter: "")
    }
}
