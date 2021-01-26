//
//  VerifyMealType.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-01-07.
//

import Foundation
import SwiftUI

struct VeryfyMealType {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    func check() {
        var arrayMealTypes = [String]()
        for mealType in mealTypes {
            arrayMealTypes.append(mealType.wrappedType)
        }
        for recipe in recipes {
            if !arrayMealTypes.contains(recipe.wrappedType){
                recipe.type = "Other"
                try? self.moc.save()
            }
        }
        
    }
    
}
