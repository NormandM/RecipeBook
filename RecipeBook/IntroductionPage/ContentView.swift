//
//  ContentView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-07-31.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
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
                NavigationLink(destination: MealTypeList( mealTypes: mealTypes), isActive: $showingMealTypes) {EmptyView()}
                
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
                            .font(Font.custom("Zapfino", size: 20))
                            .fontWeight(.heavy)
                    }
                    HStack {
                    Text(NSLocalizedStringFunc(key: "Number of recipes:"))
                        .font(.footnote)
                        .fontWeight(.light)
                        .italic()
                    Text("\(recipes.count)")
                        .font(.footnote)
                        .fontWeight(.light)
                        .italic()
                    }
                    Spacer()
                    Button(action: {
                        showingAddScreen = true
                    }){
                        Text(NSLocalizedStringFunc(key:"Add a Recipe"))
                            .font(Font.custom("Zapfino", size: 20))
                            .fontWeight(.heavy)
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
                            .font(Font.custom("Zapfino", size: 20))
                            .fontWeight(.heavy)
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
                }
            }
            .navigationBarTitle(Text(NSLocalizedStringFunc(key:"Recipe Book")))
            .navigationBarColor(UIColorReference.specialGreen)
            .edgesIgnoringSafeArea([.bottom])
            .onAppear{
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
