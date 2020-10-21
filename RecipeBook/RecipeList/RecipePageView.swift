//
//  RecipePageView.swift
//  RecipeBook
//
//  Created by NORMAND MARTIN on 2020-10-18.
//

import SwiftUI

struct RecipePageView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: []) var mealTypes: FetchedResults<MealType>
    var body: some View {
        ZStack{
            // ColorReference.specialCoral
           
            TabView {
                ForEach (0 ..< mealTypes.count) { number in
                    VStack {
//                        Text(mealTypes[number].wrappedType)
//                            .foregroundColor(.white)
//                            .padding()
                            
                        List{
                            Section(header: Text(mealTypes[number].wrappedType)){
                            FilteredrecipeListView(filter: mealTypes[number].wrappedType)
                            }
                        }
                        
                    }


                }
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationBarTitle("RECIPES", displayMode: .inline)
            .background(ColorReference.specialSand)
            .navigationBarColor(UIColorReference.specialGreen)
        }
        .onAppear{
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        }
        
    }
}

struct RecipePageView_Previews: PreviewProvider {
    static var previews: some View {
        RecipePageView()
    }
}
