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
    @FetchRequest(entity: MealType.entity(), sortDescriptors: []) var mealTypes: FetchedResults<MealType>
    @State private var showRecipeListView = false
    @State private var showingAddScreen = false
    @State private var showingMealTypes = false
    @State private var name = UserDefaults.standard.string(forKey: "name")
    @State private var showMealTypeList = false
    @State private var showSheet = false
    var body: some View {
        NavigationView{
            
            ZStack {
                NavigationLink(destination: RecipeListView(), isActive: $showRecipeListView) {
                    Text("")
                }
                VStack {
                    Text("Count: \(recipes.count)")
                    Button(action: {
                        self.showRecipeListView = true
                    }){
                        Text("Show Recipe List")
                    }
                    Button("Edit Meal Types"){
                        showingMealTypes = true
                    }.sheet(isPresented: $showingMealTypes){
                        MealTypeList().environment(\.managedObjectContext, self.moc)
                    }
                    Button ("Add Recipe") {
                        showingAddScreen = true
                    }.sheet(isPresented: $showingAddScreen){
                        AddRecipe().environment(\.managedObjectContext, self.moc)
                    }
                }
                .navigationBarTitle("Recipe Book")
            }
        }
    }
}
func userAlreadyExist(name: String) -> Bool {
    return UserDefaults.standard.object(forKey: name) != nil
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
