//
//  Recipe+CoreDataProperties.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-08.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var chef: String?
    @NSManaged public var id: UUID?
    @NSManaged public var ingredient: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var pdfPreparation: Data?
    @NSManaged public var pdfIngredient: Data?
    @NSManaged public var preparation: String?
    @NSManaged public var rating: Int16
    @NSManaged public var servings: String?
    @NSManaged public var type: String?
    @NSManaged public var timeToCook: String?
    @NSManaged public var timeToPrepare: String?
    @NSManaged public var recipeURLAdress: String?
    @NSManaged public var calcium : String?
    @NSManaged public var calories : String?
    @NSManaged public var carbohydrate : String?
    @NSManaged public var cholesterol : String?
    @NSManaged public var iron : String?
    @NSManaged public var potassium : String?
    @NSManaged public var protein : String?
    @NSManaged public var saturatedFat : String?
    @NSManaged public var sodium : String?
    @NSManaged public var totalFat : String?
    @NSManaged public var transFat : String?
    @NSManaged public var vitaminD : String?
    @NSManaged public var sugar : String?
    @NSManaged public var imageName: String?
    
    var wrappedChef: String {
        chef ?? ""
    }
    var wrappedIngredientf: String {
        ingredient ?? ""
    }
    var wrappedName: String {
        name ?? ""
    }
    var wrappedImageName: String {
        imageName ?? ""
    }
    var wrappedPreparation: String {
        preparation ?? ""
    }
    var wrappedType: String {
        type ?? NSLocalizedStringFunc(key:"Other")
    }
    var wrappedPhoto: Data {
        photo ?? Data()
    }
    var wrappedPdfPreparation: Data{
        pdfPreparation ?? Data()
    }
    var wrappedPdfIngredient: Data{
        pdfIngredient ?? Data()
    }
    var wrappedrecipeURLAdress: String {
        recipeURLAdress ?? ""
    }
    var wrappedTimeToPrepare: String {
        timeToPrepare ?? ""
    }
    var wrappedTimeToCook: String {
        timeToCook ?? ""
    }
    var wrappedCalcium: String {
        calcium ?? ""
    }
    var wrappedCalories: String {
        calories ?? ""
    }
    var wrappedCarbohydrate: String {
        carbohydrate ?? ""
    }
    var wrappedCholesterol: String {
        cholesterol ?? ""
    }
    var wrappedIron: String {
        iron ?? ""
    }
    var wrappedPotassium: String {
        potassium ?? ""
    }
    var wrappedProtein: String {
        protein ?? ""
    }
    var wrappedSaturatedFat: String {
        saturatedFat ?? ""
    }
    var wrappedSodium: String {
        sodium ?? ""
    }
    var wrappedTotalFat: String {
        totalFat ?? ""
    }
    var wrappedTransFat: String {
        transFat ?? ""
    }
    var wrappedVitaminD: String {
        vitaminD ?? ""
    }
    var wrappedSugar: String {
        sugar ?? ""
    }
    var wrappedId: UUID {
        id ?? UUID()
    }
    var wrappedServings: String {
        servings ?? ""
    }



}

extension Recipe : Identifiable {

}
