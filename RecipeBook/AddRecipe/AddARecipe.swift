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
    @EnvironmentObject var savedValue: SavedValue
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    var fetchRequestRecipe: FetchRequest<Recipe>
    @State private var isNewRecipe: Bool
    @State private var typeNumber: Int
    @State private var servings = ""
    @State private var isInitialValue = true
    @State private var showAlertRecipeNotSaved = false
    init(filter: String, isNewRecipe: Bool, typeNumber: Int){
        fetchRequestRecipe = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [],predicate: NSPredicate(format: "name == %@", filter))
        self._isNewRecipe = State(initialValue: isNewRecipe)
        self._typeNumber = State(initialValue: typeNumber)
    }
    var array : Array<Int> = [0,1,2,3,4,5,6,7,8,9,10,11,12]
    @State private var data: Data?
    @State private var existingData = Data()
    @State private var preparationPdf = Data()
    @State private var ingredientPdf = Data()
    @State private var existingPreparationPdf = Data()
    @State private var existingIngredientPdf = Data()
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
    @State private var showAlertSameName = false
    @State private var showAlertNoName = false
    @State private var recipeUrl = ""
    @State private var arrayName = [String]()
    @State private var arrayId = [UUID]()
    @State private var currentRecipe: Recipe?
    @State private var showAlerts = false
    @State private var activeAlert: ActiveAlert = ActiveAlert.showAlertRecipeNotSaved
    var body: some View {
        Form {
            Section {
                TextField("Name of recipe", text: $name, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: name, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField("Name of Chef", text: $chef, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: chef, perform: { newValue in
                    savedValue.recipeSaved = false
                })

                TextField("Preparation Time", text: $timeToPrepare, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: timeToPrepare, perform: { newValue in
                    savedValue.recipeSaved = false
                })

                TextField("Cooking Time", text: $timeToCook, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: timeToCook, perform: { newValue in
                    savedValue.recipeSaved = false
                })

                TextField("Servings", text: $servings, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: servings, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                
                Section {
                    TextField("Recipe website address", text: $recipeUrl, onCommit: {
                        UIApplication.shared.endEditing()
                    })
                    .onChange(of: recipeUrl, perform: { newValue in
                        savedValue.recipeSaved = false
                    })
                    
                }
                Picker("Category: ", selection: $typeNumber){
                    ForEach(0 ..< mealTypes.count){mealtypeNo in
                        HStack {
                            if mealTypes[mealtypeNo].wrappedType != "" {
                                Text( NSLocalizedStringFunc(key:"\(mealTypes[mealtypeNo].wrappedType)"))
                                    .font(.subheadline)
                                Image(mealTypes[mealtypeNo].wrappedTypeImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50.0, height: 50.0)
                            }
                            
                        }
                        .onChange(of: mealtypeNo, perform: { newValue in
                            savedValue.recipeSaved = false
                        })
                    }
                    
                }
                RatingView(rating: $rating, isInteractif: true)
            }
            Section {
                NavigationLink(destination: NutritionalFactsView(calcium: $calcium, calories: $calories, carbohydrate: $carbohydrate, cholesterol: $cholesterol, iron: $iron, potassium: $potassium, protein: $protein, saturatedFat: $saturatedFat, sodium: $sodium, totalFat: $totalFat, transFat: $transFat, vitaminD: $vitaminD, sugar: $sugar,existingcalciumRecipe: calcium,existingCaloriesRecipe: calories, existingCarbohydrateRecipe: carbohydrate, existingCholesterolRecipe: cholesterol, existingIronRecipe: iron, existingPotassiumRecipe: potassium, existingProteinRecipe: protein, existingSaturatedFatRecipe: saturatedFat, existingSodiumRecipe: sodium, existingTotalFatRecipe: totalFat, existingTransFatRecipe: transFat, existingVitaminDRecipe: vitaminD, existingSugarRecipe: sugar)){
                    Text("Nutritional Infos")
                }
                NavigationLink(destination: IngredientView(ingredient: $ingredient,  pdfIngredient: $ingredientPdf, existingIngredient: ingredient, existingIngredientPdf: ingredientPdf)){
                    Text("Ingredients")
                }.buttonStyle(PlainButtonStyle())
                .onChange(of: ingredientPdf, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                .onChange(of: ingredient, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                
                
                NavigationLink(destination: PreparationView(preparation: $preparation, pdfPreparation: $preparationPdf, existingPreparation: preparation, existingPreparationPdf: preparationPdf)){
                    Text("Preparation")
                }
                .onChange(of: preparation, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                .onChange(of: preparationPdf, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                NavigationLink(destination: PhotoView(data: $data, existingdata: data ?? Data())){
                    Text("Photo")
                }
                .onChange(of: data, perform: { newValue in
                    savedValue.recipeSaved = false
                })
            }
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        }
 

        .onAppear{
            savedValue.recipeSaved = true
            savedValue.noChangesMade = true
     //       recipeSaved = false
            showAlerts = false
            for recipe in fetchRequestRecipe.wrappedValue{
                if recipe.wrappedName != "" {
                    name = recipe.wrappedName
                    chef = recipe.wrappedChef
                    servings = recipe.wrappedServings
                    timeToPrepare = recipe.wrappedTimeToPrepare
                    timeToCook = recipe.wrappedTimeToPrepare
                    rating = Int(recipe.rating)
                    recipeUrl = recipe.wrappedrecipeURLAdress
                    if ingredient == "" && isInitialValue {ingredient = recipe.wrappedIngredient}
                    if preparation == "" && isInitialValue {preparation = recipe.wrappedPreparation}
                    if preparationPdf == Data() && isInitialValue {preparationPdf = recipe.wrappedPdfPreparation}
                    if ingredientPdf == Data() && isInitialValue {ingredientPdf = recipe.wrappedPdfIngredient}
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
                    if data == nil && isInitialValue {data = recipe.wrappedPhoto}
                    id = recipe.wrappedId
                    
                }
            }
        }
        
        .navigationBarTitle("Add a Recipe", displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: isIPhonePresent() ?
                                ButtonView(showAlerts: $showAlerts, activeAlert: $activeAlert, clearDisk: clearDisk, recipes: recipes, areAllChangesSaved: areAllChangesSaved, sameName: sameName, name: self.name)
                                .padding()
                                
                                : nil
                            ,trailing:
                                Button(action: {
                                    saveRecipe()
                                }, label: {
                                    
                                    Image(systemName: "square.and.arrow.down")
                                        .font(.title)
                                })
                                .padding()
                            
        )
        .alert(isPresented: $showAlerts) {
            switch activeAlert {
            case .showAlertRecipeSaved:
                return Alert(title: Text("Recipe was saved"), message: Text(""), dismissButton: Alert.Button.default(
                    Text("OK"), action: {
                //        recipeSaved = false
                        activeAlert = ActiveAlert.showAlertRecipeNotSaved
                        showAlerts = false
                    }
                ))
            case .showAlertSameName:
                return Alert(title: Text("Recipe Name already exists"), message: Text("Please choose another name"), dismissButton: .default(Text("Ok"), action: {
                    activeAlert = ActiveAlert.showAlertRecipeNotSaved
                    showAlerts = false
                }))
            case .showAlertNoName:
                return Alert(title: Text("Recipe has no name"), message: Text("Please choose a name"), dismissButton: .default(Text("Ok"), action: {
                    activeAlert = ActiveAlert.showAlertRecipeNotSaved
                    showAlerts = false
                }))
            case .showAlertRecipeNotSaved:
                return Alert(title: Text("Recipe was not saved"), message: Text("Do you want to save before leaving the page?"), primaryButton: .default(Text("Save"), action: {
                    activeAlert = ActiveAlert.showAlertRecipeNotSaved
                    showAlerts = false
                    saveRecipe()
                    clearDisk()
                    self.presentationMode.wrappedValue.dismiss()
                }), secondaryButton: .default(Text("Do not save"), action: {
                    UIApplication.shared.endEditing()
                    savedValue.recipeSaved = true
                    self.presentationMode.wrappedValue.dismiss()
                }))
            }
        }
        
    }
    func saveRecipe(){
        arrayName = [String]()
        print("a")
        if self.name == ""{
            print("b")
            showAlerts = true
            activeAlert = .showAlertNoName
        }else if !isNewRecipe{
            print("c")
            if fetchRequestRecipe.wrappedValue.count != 0 {
                print("d")
                let existingRecipe = fetchRequestRecipe.wrappedValue[0]
                save(recipe: existingRecipe)
            }else{
                print("e")
                save(recipe: currentRecipe!)
            }
            
        }else{
            activeAlert = sameName(recipes: recipes)
            
            if !savedValue.recipeSaved && activeAlert != .showAlertSameName{
                print("g")
                currentRecipe = Recipe(context: self.moc)
                isNewRecipe = false
                save(recipe: currentRecipe!)
                UIApplication.shared.endEditing()
            }

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
        recipe.pdfIngredient = ingredientPdf
        recipe.pdfPreparation = preparationPdf
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
        savedValue.recipeSaved = true
        showAlerts = true
        activeAlert = .showAlertRecipeSaved
        showAlertRecipeNotSaved = false
    }
    func formArray(recipes: FetchedResults<Recipe>) {
        arrayId = [UUID]()
        arrayName = [String]()
        
        for recipe in recipes {
            arrayName.append(recipe.wrappedName)
            arrayId.append(recipe.wrappedId)
        }
    }
    func clearDisk() -> Void{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var docURL = documentDirectory.appendingPathComponent("Preparation.pdf")
        try? FileManager.default.removeItem(at: docURL)
        docURL = documentDirectory.appendingPathComponent("Ingredient.pdf")
        try? FileManager.default.removeItem(at: docURL)
        docURL = documentDirectory.appendingPathComponent("ingredients")
        try? FileManager.default.removeItem(at: docURL)
        docURL = documentDirectory.appendingPathComponent("preparation")
        try? FileManager.default.removeItem(at: docURL)
        self.presentationMode.wrappedValue.dismiss()
    }
    func isIPhonePresent() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return true
        }else{
            return false
        }
    }
    func areAllChangesSaved(recipes: FetchedResults<Recipe>) -> ActiveAlert{
        var saved = false
        for recipe in recipes {
            if recipe.name == self.name{
                if
                recipe.chef == self.chef &&
                recipe.ingredient == self.ingredient &&
                recipe.type == mealTypes[typeNumber].type &&
                recipe.imageName == mealTypes[typeNumber].typeImage &&
                recipe.name == self.name &&
                recipe.timeToPrepare == self.timeToPrepare &&
                recipe.timeToCook == self.timeToCook &&
                recipe.preparation == self.preparation &&
                recipe.rating == Int16(self.rating) &&
                recipe.photo == data &&
                recipe.pdfIngredient == ingredientPdf &&
                recipe.pdfPreparation == preparationPdf &&
                recipe.calcium == self.calcium &&
                recipe.calories == self.calories &&
                recipe.carbohydrate == self.carbohydrate &&
                recipe.cholesterol == self.cholesterol &&
                recipe.iron == self.iron &&
                recipe.potassium == self.potassium &&
                recipe.protein == self.protein &&
                recipe.saturatedFat == self.saturatedFat &&
                recipe.sodium == self.sodium &&
                recipe.totalFat == self.totalFat &&
                recipe.transFat == self.transFat &&
                recipe.vitaminD == self.vitaminD &&
                recipe.sugar == self.sugar &&
                recipe.servings == self.servings &&
                recipe.recipeURLAdress == self.recipeUrl{
                    saved = true
                    savedValue.recipeSaved = true
                }
            }
        }
        if saved {
            showAlerts = false
            return .showAlertRecipeNotSaved
        }else{
            showAlerts = true
            return .showAlertRecipeNotSaved
        }
        
    }
    func sameName(recipes: FetchedResults<Recipe>) -> ActiveAlert{
        formArray(recipes: recipes)
        print(arrayName)
        if arrayName.contains(self.name){
            print("In same name")
            showAlerts = true
            return ActiveAlert.showAlertSameName
        }else{
            showAlerts = false
            return ActiveAlert.showAlertNoName
        }
    }

}

//struct AddARecipe_Previews: PreviewProvider {
//    static var previews: some View {
//        AddARecipe(filter: "", isNewRecipe: false, typeNumber: 0, showAlertRecipeNotSaved: false)
//    }
//}

