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
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Count: \(recipes.count)")
                    .navigationBarTitle("Recipe Bokk")
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
