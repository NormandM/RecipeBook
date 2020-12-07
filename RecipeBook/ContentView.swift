//
//  ContentView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-07-31.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.typeImage, ascending: true)]) var mealTypeImage: FetchedResults<MealType>
    @State private var showRecipeListView = false
    @State private var showingAddScreen = false
    @State private var showingMealTypes = false
    @State private var showMealTypeList = false
    @State private var showtest = false
    @State private var arrayMealTypes = [String]()
    var body: some View {
        NavigationView{
            ZStack {
                ColorReference.specialSand
                    .edgesIgnoringSafeArea(.all)
                NavigationLink(destination: RecipePageView(), isActive: $showRecipeListView) {
                    Text("")
                }
                NavigationLink(destination: AddARecipe(filter: "", isNewRecipe: true, typeNumber: 0), isActive: $showingAddScreen) {
                    Text("")
                }
                NavigationLink(destination: MealTypeList( mealTypes: mealTypes), isActive: $showingMealTypes) {
                    Text("")
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        self.showRecipeListView = true
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
                        showingMealTypes = true
                    }){
                        Text(NSLocalizedStringFunc(key:"Meal Categories"))
                            .font(Font.custom("Zapfino", size: 20))
                            .fontWeight(.heavy)
                    }

                    Spacer()
                }
                .navigationBarTitle(Text(NSLocalizedStringFunc(key:"Recipe Book")))
                .navigationBarColor(UIColorReference.specialGreen)
                
            }
            .onAppear{
                for meal in mealTypes {
                    arrayMealTypes.append(meal.wrappedType)
                    print(meal.wrappedType)
                }
                print(arrayMealTypes.count)
                if arrayMealTypes.count == 0 {
                    UserDefaults.standard.set(true, forKey: "First Lauch")
                    let newMealCategory = MealType(context: self.moc)
                    newMealCategory.id = UUID()
                    newMealCategory.type = NSLocalizedStringFunc(key:"Appetizer")
                    newMealCategory.typeImage = "Appetizer"
                    let newMealCategory2 = MealType(context: self.moc)
                    newMealCategory2.id = UUID()
                    newMealCategory2.type = NSLocalizedStringFunc(key:"Breakfast")
                    newMealCategory2.typeImage = "Breakfast"
                    let newMealCategory3 = MealType(context: self.moc)
                    newMealCategory3.id = UUID()
                    newMealCategory3.type = NSLocalizedStringFunc(key:"Dessert")
                    newMealCategory3.typeImage = "Dessert"
                    let newMealCategory4 = MealType(context: self.moc)
                    newMealCategory4.id = UUID()
                    newMealCategory4.type = NSLocalizedStringFunc(key:"Fish")
                    newMealCategory4.typeImage = "Fish"
                    let newMealCategory5 = MealType(context: self.moc)
                    newMealCategory5.id = UUID()
                    newMealCategory5.type = NSLocalizedStringFunc(key:"Meat")
                    newMealCategory5.typeImage = "Meat"
                    let newMealCategory6 = MealType(context: self.moc)
                    newMealCategory6.id = UUID()
                    newMealCategory6.type = NSLocalizedStringFunc(key:"Other")
                    newMealCategory6.typeImage = "Other"
                    let newMealCategory7 = MealType(context: self.moc)
                    newMealCategory7.id = UUID()
                    newMealCategory7.type = NSLocalizedStringFunc(key:"Pasta")
                    newMealCategory7.typeImage = "Pasta"
                    let newMealCategory8 = MealType(context: self.moc)
                    newMealCategory8.id = UUID()
                    newMealCategory8.type = NSLocalizedStringFunc(key:"Poultry")
                    newMealCategory8.typeImage = "Poultry"
                    let newMealCategory9 = MealType(context: self.moc)
                    newMealCategory9.id = UUID()
                    newMealCategory9.type = NSLocalizedStringFunc(key:"Salad")
                    newMealCategory9.typeImage = "Salad"
                    let newMealCategory10 = MealType(context: self.moc)
                    newMealCategory10.id = UUID()
                    newMealCategory10.type = NSLocalizedStringFunc(key:"Sauce")
                    newMealCategory10.typeImage = "Sauce"
                    let newMealCategory11 = MealType(context: self.moc)
                    newMealCategory11.id = UUID()
                    newMealCategory11.type = NSLocalizedStringFunc(key:"Soup")
                    newMealCategory11.typeImage = "Soup"
                    let newMealCategory12 = MealType(context: self.moc)
                    newMealCategory12.id = UUID()
                    newMealCategory12.type = NSLocalizedStringFunc(key:"Vegetable")
                    newMealCategory12.typeImage = "Vegetable"
                    try? self.moc.save()
                }
            }
        }
    }
}
func userAlreadyExist(name: String) -> Bool {
    return UserDefaults.standard.object(forKey: "name") != nil
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
