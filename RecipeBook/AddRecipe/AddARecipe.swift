//
//  AddARecipe.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-28.
//

import SwiftUI
import CoreData
struct AddARecipe: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    var fetchRequestRecipe: FetchRequest<Recipe>
    @State private var isNewRecipe: Bool
    @State private var typeNumber: Int
    @State private var servings = ""
    @State private var isInitialValue = true
    init(filter: String, isNewRecipe: Bool, typeNumber: Int){
        fetchRequestRecipe = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [],predicate: NSPredicate(format: "name == %@", filter))
        self._isNewRecipe = State(initialValue: isNewRecipe)
        self._typeNumber = State(initialValue: typeNumber)
    }
    var array : Array<Int> = [0,1,2,3,4,5,6,7,8,9,10,11,12]
    @State private var data: Data?
    @State private var existingData = Data()
    @State private var preparationPdf = Data()
    @State private var existingPreparationPdf = Data()
    @State private var chef = ""
    @State private var timeToPrepare = ""
    @State private var timeToCook = ""
    @State private var ingredient = ""
    @State private var name = ""
    @State private var preparation = ""
    @State private var rating = 3
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
    @State private var id = UUID()
    @State private var recipeSaved = false
    @State private var showAlertSameName = false
    @State private var showAlertNoName = false
    @State private var showAlertRecipeNotSaved = false
    @State private var recipeUrl = ""
    @State private var arrayName = [String]()
    @State private var arrayId = [UUID]()
    @State private var newRecipe = Recipe()
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
                            if mealTypes[mealtypeNo].wrappedType != "" {
                            Text("\(mealTypes[mealtypeNo].wrappedType)")
                            Image(mealTypes[mealtypeNo].wrappedTypeImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50.0, height: 50.0)
                            }

                        }
                        
                    }
                }

                RatingView(rating: $rating, isInteractif: true)
                TextField("Servings", text: $servings, onCommit: {
                    UIApplication.shared.endEditing()
                })
                
            }
            Section {
                NavigationLink(destination: NutritionalFactsView(calcium: $calcium, calories: $calories, carbohydrate: $carbohydrate, cholesterol: $cholesterol, iron: $iron, potassium: $potassium, protein: $protein, saturatedFat: $saturatedFat, sodium: $sodium, totalFat: $totalFat, transFat: $transFat, vitaminD: $vitaminD, sugar: $sugar,existingcalciumRecipe: calcium,existingCaloriesRecipe: calories, existingCarbohydrateRecipe: carbohydrate, existingCholesterolRecipe: cholesterol, existingIronRecipe: iron, existingPotassiumRecipe: potassium, existingProteinRecipe: protein, existingSaturatedFatRecipe: saturatedFat, existingSodiumRecipe: sodium, existingTotalFatRecipe: totalFat, existingTransFatRecipe: transFat, existingVitaminDRecipe: vitaminD, existingSugarRecipe: sugar)){
                    Text("Nutrition Facts")
                }
                NavigationLink(destination: IngredientView(ingredient: $ingredient, existingIngredient: ingredient, isInitialValue: $isInitialValue)){
                    Text("Ingredients")
                }.buttonStyle(PlainButtonStyle())
                NavigationLink(destination: PreparationView(preparation: $preparation, pdfPreparation: $preparationPdf, existingPreparation: preparation, existingPreparationPdf: existingPreparationPdf)){
                    Text("Preparation")
                }
                NavigationLink(destination: PhotoView(data: $data, existingdata: data ?? Data())){
                    Text("Photo")
                }
            }
            Section {
                TextField("Recipe website address", text: $recipeUrl, onCommit: {
                    UIApplication.shared.endEditing()
                })
            }
        }

        .onAppear{
            print(servings)
            print(typeNumber)
            for recipe in fetchRequestRecipe.wrappedValue{

                if recipe.wrappedName != "" {
                    name = recipe.wrappedName
                    chef = recipe.wrappedChef
                    servings = recipe.wrappedServings
                    timeToPrepare = recipe.wrappedTimeToPrepare
                    timeToCook = recipe.wrappedTimeToPrepare
                    rating = Int(recipe.rating)
                    recipeUrl = recipe.wrappedrecipeURLAdress
                    if ingredient == "" && isInitialValue {
                        ingredient = recipe.wrappedIngredientf
                        print("ingredient: \(ingredient)")
                    }
                    if preparation == "" && isInitialValue {preparation = recipe.wrappedPreparation}
                    if calcium == "" && isInitialValue {calcium = recipe.wrappedCalcium}
                    if calories == "" && isInitialValue {calories = recipe.wrappedCalories}
                    if carbohydrate == "" && isInitialValue {carbohydrate = recipe.wrappedCarbohydrate}
                    if cholesterol == "" && isInitialValue {cholesterol = recipe.wrappedCholesterol}
                    if iron == "" && isInitialValue {iron = recipe.wrappedIron}
                    if potassium == "" && isInitialValue {potassium = recipe.wrappedPotassium}
                    if protein == "" && isInitialValue {protein = recipe.wrappedProtein}
                    if saturatedFat == "" && isInitialValue {saturatedFat = recipe.wrappedSaturatedFat}
                    if sodium == "" && isInitialValue {sodium = recipe.wrappedSodium}
                    if totalFat == "" && isInitialValue {totalFat = recipe.wrappedTotalFat}
                    if transFat == "" && isInitialValue {transFat = recipe.wrappedTransFat}
                    if vitaminD == "" && isInitialValue {vitaminD = recipe.wrappedVitaminD}
                    if sugar == "" && isInitialValue {sugar = recipe.wrappedSugar}
                    if data == nil && isInitialValue {
                        data = recipe.wrappedPhoto
                    }
                    id = recipe.wrappedId
                }
            }
        }

        .navigationBarTitle("Add a Recipe", displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            if !recipeSaved{
                showAlertRecipeNotSaved = true
            }else{
                self.presentationMode.wrappedValue.dismiss()
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
                self.presentationMode.wrappedValue.dismiss()
            }), secondaryButton: .default(Text("Do not save"), action: {
                UIApplication.shared.endEditing()
                self.presentationMode.wrappedValue.dismiss()
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
        arrayName = [String]()
        arrayId = [UUID]()
        formArray(recipes: recipes)
        if self.name == ""{
            showAlertNoName = true
        }else if arrayId.contains(self.id) && !isNewRecipe{
            print("exists")
            if fetchRequestRecipe.wrappedValue.count != 0 {
                let existingRecipe = fetchRequestRecipe.wrappedValue[0]
                save(recipe: existingRecipe)
            }

        }else if isNewRecipe{
            if !recipeSaved {
                newRecipe = Recipe(context: self.moc)
                isNewRecipe = false
            }
            
            formArray(recipes: recipes)
            if arrayName.contains(self.name){
               showAlertSameName = true
            }else{
                save(recipe: newRecipe)
            }
            
            UIApplication.shared.endEditing()
        }
        
    }
    func save(recipe: Recipe){
        recipe.chef = self.chef
        recipe.ingredient = self.ingredient
        recipe.type = mealTypes[typeNumber].type
        recipe.imageName = mealTypes[typeNumber].typeImage
        recipe.name = self.name
        recipe.timeToPrepare = self.timeToPrepare
        recipe.timeToCook = self.timeToCook
        recipe.preparation = self.preparation
        recipe.rating = Int16(self.rating)
        recipe.photo = data
        recipe.calcium = self.calcium
        recipe.calories = self.calories
        recipe.carbohydrate = self.carbohydrate
        recipe.cholesterol = self.cholesterol
        recipe.iron = self.iron
        recipe.potassium = self.potassium
        recipe.protein = self.protein
        recipe.saturatedFat = self.saturatedFat
        recipe.sodium = self.sodium
        recipe.totalFat = self.totalFat
        recipe.transFat = self.transFat
        recipe.vitaminD = self.vitaminD
        recipe.sugar = self.sugar
        recipe.servings = self.servings
        recipe.recipeURLAdress = self.recipeUrl
        recipe.id = self.id
        do {
            try self.moc.save()
        } catch {
            print("same name")
        }
        recipeSaved = true
    }
    func formArray(recipes: FetchedResults<Recipe>) {
        for recipe in recipes {
            arrayName.append(recipe.wrappedName)
            arrayId.append(recipe.wrappedId)
        }
    }
}

struct AddARecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddARecipe(filter: "", isNewRecipe: false, typeNumber: 0)
    }
}

