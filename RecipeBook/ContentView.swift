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
    @State private var showRecipeListView = false
    @State private var showingAddScreen = false
    @State private var showingMealTypes = false
    @State private var showMealTypeList = false
    @State private var showtest = false

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
                        Text("Recipe List")
                            .font(Font.custom("Zapfino", size: 20))
                            .fontWeight(.heavy)
                    }
                    Text("(Number of recipes: \(recipes.count))")
                        .font(.footnote)
                        .fontWeight(.light)
                        .italic()
                    Spacer()
                    Button(action: {
                        showingAddScreen = true
                    }){
                        Text("Add a Recipe")
                            .font(Font.custom("Zapfino", size: 20))
                            .fontWeight(.heavy)
                    }
                    Spacer()
                    Button(action: {
                        showingMealTypes = true
                    }){
                        Text("Meal Categories")
                            .font(Font.custom("Zapfino", size: 20))
                            .fontWeight(.heavy)
                    }

                    Spacer()


                }
                .navigationBarTitle(Text("Recipe Book"))
                .navigationBarColor(UIColorReference.specialGreen)
                
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
