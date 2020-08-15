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
    @State private var showRecipeListView = false
    @State private var showingAddScreen = false
    
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
                    

                }
                .navigationBarTitle("Recipe Book")
                .navigationBarItems(trailing:
                        Button(action: {
                            self.showingAddScreen.toggle()
                        }){
                            Image(systemName: "plus")
                        })


                    
                }
            .sheet(isPresented: $showingAddScreen) {
                AddRecipe().environment(\.managedObjectContext, self.moc)
                
            }


        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
