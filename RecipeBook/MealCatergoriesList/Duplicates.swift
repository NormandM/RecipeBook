//
//  Duplicates.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-01-08.
//

import SwiftUI
import CoreData

struct Duplicates {
    static func remove(mealTypes: FetchedResults<MealType>, moc: NSManagedObjectContext) {
        var arrayMealTypes = [String]()
        for mealType in mealTypes {
            arrayMealTypes.append(mealType.wrappedType)
        }
        let filteredArray = arrayMealTypes.unique()
        for mealType in mealTypes{
            moc.delete(mealType)
        }
        
        try? moc.save()
        for mealType in filteredArray {
            let newMealCategory = MealType(context: moc)
            newMealCategory.id = UUID()
            newMealCategory.type = mealType
            newMealCategory.typeImage = mealType
        }
        try? moc.save()
    }
}
