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
    @NSManaged public var preparation: String?
    @NSManaged public var rating: Int16
    @NSManaged public var servings: Int16
    @NSManaged public var type: String?
    @NSManaged public var timeToCook: Int16
    @NSManaged public var timeToPrepare: Int16
    @NSManaged public var nutritionFacts: String?
    @NSManaged public var recipeURLAdress: String?
    
    var wrappedChef: String {
        chef ?? ""
    }
    var wrappedIngredientf: String {
        ingredient ?? ""
    }
    var wrappedName: String {
        name ?? ""
    }
    var wrappedPreparation: String {
        preparation ?? ""
    }
    var wrappedType: String {
        type ?? ""
    }
    var wrappedPhoto: Data {
        photo ?? Data()
    }
    var wrappedNutritionFacts: String {
        nutritionFacts ?? ""
    }
    var wrappedrecipeURLAdress: String {
        recipeURLAdress ?? ""
    }

}

extension Recipe : Identifiable {

}
