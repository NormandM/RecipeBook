//
//  NoChange.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-01-22.
//

import SwiftUI
struct NoChange {
    @EnvironmentObject var savedValue: SavedValue
    let chef: String
    let ingredient: String
    let mealTypesType: String
    let mealTypesImage: String
    let name: String
    let timeToPrepare: String
    let timeToCook: String
    let preparation: String
    let rating : Int
    let data: Data?
    let ingredientPdf: Data
    let preparationPdf: Data
    let calcium: String
    let calories: String
    let carbohydrate: String
    let cholesterol: String
    let iron: String
    let potassium: String
    let protein: String
    let saturatedFat: String
    let sodium: String
    let totalFat: String
    let transFat: String
    let vitaminD: String
    let sugar: String
    let servings: String
    let recipeUrl: String
    func checkNoChangesMade()  -> Bool{
        if
        chef == "" &&
        ingredient == "" &&
        mealTypesType == "Appetizer" &&
        mealTypesImage == "Appetizer" &&
        name == "" &&
        timeToPrepare == "" &&
        timeToCook == "" &&
        preparation == "" &&
        rating == 3 &&
        data == nil &&
        ingredientPdf == Data() &&
        preparationPdf ==  Data() &&
        calcium == "" &&
        calories == "" &&
        carbohydrate == "" &&
        cholesterol == "" &&
        iron == "" &&
        potassium == "" &&
        protein == "" &&
        saturatedFat == "" &&
        sodium == "" &&
        totalFat == "" &&
        transFat == "" &&
        vitaminD == "" &&
        sugar == "" &&
        servings == "" &&
        recipeUrl == ""{
            savedValue.recipeSaved = true
            return true
        }else{
            return false
        }
        
    }

}
