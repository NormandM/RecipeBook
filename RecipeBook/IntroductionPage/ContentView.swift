//
//  ContentView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-07-31.
//

import SwiftUI
import PDFKit
import UIKit

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var savedValue: SavedValue
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.typeImage, ascending: true)]) var mealTypeImage: FetchedResults<MealType>
    @State private var showRecipeListView = false
    @State private var showingAddScreen = false
    @State private var showingMealTypes = false
    @State private var showMealTypeList = false
    @State private var showtest = false
    @State private var showAlertRecipeNotSaved = false
    @State private var pageRecipelistWasChosen = false
    @State private var arrayMealTypes = [String]()
    @State private var appIsFirstOpen = true
    @State private var firstOpenOpacity: Double = 1.0
    @State private var showUnlockBook = false
    @State private var bookNotUnlocked = false
    @State private var isUnlock: Bool = UserDefaults.standard.bool(forKey: "unlocked")
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var body: some View {
        if appIsFirstOpen {
            NMLogo(appIsFirstOpen: $appIsFirstOpen, firstOpenOpacity: $firstOpenOpacity)
                .opacity(firstOpenOpacity)
        }else{
            NavigationView{
                ZStack {
                    ColorReference.specialSand
                        .edgesIgnoringSafeArea(.all)
                    NavigationLink(destination: RecipePageView(mealTypes: mealTypes), isActive: $showRecipeListView) {EmptyView()}
                    NavigationLink(destination: AddARecipe(filter: "", isNewRecipe: true, typeNumber: 0), isActive: $showingAddScreen) {EmptyView()}
                    NavigationLink(destination: MealTypeList( mealTypes: mealTypes, recipes: recipes), isActive: $showingMealTypes) {EmptyView()}
                    NavigationLink(destination: UnlockBookView(isUnlock: $isUnlock), isActive: $showUnlockBook) {EmptyView()}
                    VStack {
                        Spacer()
                        Button(action: {
                            if savedValue.recipeSaved {
                                self.showRecipeListView = true
                            }else{
                                showAlertRecipeNotSaved = true
                                pageRecipelistWasChosen = true
                            }
                        }){
                            Text(NSLocalizedStringFunc(key: "Recipe List"))
                                .font(.title)
                                .foregroundColor(ColorReference.specialGray)
                        }
                        HStack {
                            Text(NSLocalizedStringFunc(key: "Number of recipes:"))
                                .font(.footnote)
                                .fontWeight(.light)
                                .italic()
                                .foregroundColor(colorScheme == .light ? .black : .black)
                            Text("\(recipes.count)")
                                .font(.footnote)
                                .fontWeight(.light)
                                .italic()
                                .foregroundColor(colorScheme == .light ? .black : .black)
                        }
                        Spacer()
                        Button(action: {
                            if recipes.count < 7 || isUnlock {
                                showingAddScreen = true
                            }else{
                                bookNotUnlocked = true
                            }
                            
                        }){
                            Text(NSLocalizedStringFunc(key:"Add a Recipe"))
                                .font(.title)
                                .foregroundColor(ColorReference.specialGray)
                        }
                        .alert(isPresented: $bookNotUnlocked) {
                            Alert(title: Text("Do you want to add more recipes?"), message: Text("Unlock your Recipe Book"), primaryButton: .default(Text("OK"), action: {
                                showUnlockBook = true
                            }), secondaryButton: .default(Text("Not now"), action: {
                                bookNotUnlocked = false
                            }))
                        }
                        
                        Spacer()
                        Button(action: {
                            if savedValue.recipeSaved {
                                showingMealTypes = true
                            }else{
                                showAlertRecipeNotSaved = true
                            }
                        }){
                            Text(NSLocalizedStringFunc(key:"Meal Types"))
                                .font(.title)
                                .foregroundColor(ColorReference.specialGray)
                        }
                        .alert(isPresented: $showAlertRecipeNotSaved) {
                            Alert(title: Text("Recipe was not saved"), message: Text("Do you want to save before leaving the page?"), primaryButton: .default(Text("OK"), action: {
                                showingAddScreen = true
                            }), secondaryButton: .default(Text("Do not save"), action: {
                                UIApplication.shared.endEditing()
                                if pageRecipelistWasChosen {
                                    showRecipeListView = true
                                }else{
                                    showingMealTypes = true
                                }
                                savedValue.recipeSaved = true
                            }))
                        }
                        Spacer()
                        Button(action: {
                            showUnlockBook = true
                        }){
                            Text(NSLocalizedStringFunc(key:"Unlock Book"))
                                .font(.title)
                                .foregroundColor(ColorReference.specialGray)
                        }
                        Spacer()
                    }
                    .navigationBarTitle(Text(NSLocalizedStringFunc(key:"Recipe Book")))
                    .navigationBarColor(UIColorReference.specialGreen)
                    .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
                }
                .onAppear{
                    IAPManager.shared.getProductsV5()
                    if !UserDefaults.standard.bool(forKey: "unlocked"){
                        IAPManager.shared.restorePurchasesV5()
                    }
                    if mealTypes.count == 0 {
                        let newMealCategory = MealType(context: self.moc)
                        newMealCategory.id = UUID()
                        newMealCategory.type = "Appetizer"
                        newMealCategory.typeImage = "Appetizer"
                        let newMealCategory2 = MealType(context: self.moc)
                        newMealCategory2.id = UUID()
                        newMealCategory2.type = "Breakfast"
                        newMealCategory2.typeImage = "Breakfast"
                        let newMealCategory3 = MealType(context: self.moc)
                        newMealCategory3.id = UUID()
                        newMealCategory3.type = "Dessert"
                        newMealCategory3.typeImage = "Dessert"
                        let newMealCategory4 = MealType(context: self.moc)
                        newMealCategory4.id = UUID()
                        newMealCategory4.type = "Fish"
                        newMealCategory4.typeImage = "Fish"
                        let newMealCategory5 = MealType(context: self.moc)
                        newMealCategory5.id = UUID()
                        newMealCategory5.type = "Meat"
                        newMealCategory5.typeImage = "Meat"
                        let newMealCategory6 = MealType(context: self.moc)
                        newMealCategory6.id = UUID()
                        newMealCategory6.type = "Other"
                        newMealCategory6.typeImage = "Other"
                        let newMealCategory7 = MealType(context: self.moc)
                        newMealCategory7.id = UUID()
                        newMealCategory7.type = "Pasta"
                        newMealCategory7.typeImage = "Pasta"
                        let newMealCategory8 = MealType(context: self.moc)
                        newMealCategory8.id = UUID()
                        newMealCategory8.type = "Poultry"
                        newMealCategory8.typeImage = "Poultry"
                        let newMealCategory9 = MealType(context: self.moc)
                        newMealCategory9.id = UUID()
                        newMealCategory9.type = "Salad"
                        newMealCategory9.typeImage = "Salad"
                        let newMealCategory10 = MealType(context: self.moc)
                        newMealCategory10.id = UUID()
                        newMealCategory10.type = "Sauce"
                        newMealCategory10.typeImage = "Sauce"
                        let newMealCategory11 = MealType(context: self.moc)
                        newMealCategory11.id = UUID()
                        newMealCategory11.type = "Soup"
                        newMealCategory11.typeImage = "Soup"
                        let newMealCategory12 = MealType(context: self.moc)
                        newMealCategory12.id = UUID()
                        newMealCategory12.type = "Vegetable"
                        newMealCategory12.typeImage = "Vegetable"
                        try? self.moc.save()
                    }
                    
                    Duplicates.remove(mealTypes: mealTypes, moc: moc)
                    for number in 0 ..< mealTypes.count {
                        arrayMealTypes.append(mealTypes[number].wrappedType)
                    }
                    if recipes.count == 0 {
                        let newRecipe = Recipe(context: self.moc)
                        newRecipe.id = UUID()
                        newRecipe.imageName = "ImageGateau"
                        newRecipe.name = "Gâteau aux fruits"
                        let preparationImage = UIImage(named: "PreparationGateau")
                        let pdfPage = PDFPage(image: preparationImage ?? UIImage())
                        let pdfDocument = PDFDocument()
                        pdfDocument.insert(pdfPage ?? PDFPage(), at: 0)
                        newRecipe.pdfPreparation = pdfDocument.dataRepresentation()
                        let ingredientImage = UIImage(named: "IngredientGateau")
                        let pdfPage2 = PDFPage(image: ingredientImage ?? UIImage())
                        let pdfDocument2 = PDFDocument()
                        pdfDocument2.insert(pdfPage2 ?? PDFPage(), at: 0)
                        newRecipe.pdfIngredient = pdfDocument2.dataRepresentation()
                        let uiImage = UIImage(named: "ImageGateau")
                        let dataImage = uiImage?.jpeg(.lowest)
                        newRecipe.photo = dataImage
                        newRecipe.rating = 5
                        newRecipe.servings = "12"
                        newRecipe.timeToCook = "60 minutes"
                        newRecipe.timeToPrepare = "40 minutes"
                        newRecipe.type = "Dessert"
                        newRecipe.imageName = "Dessert"
                        newRecipe.chef = "Oralia"
                        try? self.moc.save()
                    }
                }
                Image("IconeRecipe")
                    .resizable()
                    .navigationBarColor(UIColorReference.specialGreen)
                    .edgesIgnoringSafeArea([.bottom])
                
            }
            .phoneOnlyStackNavigationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
