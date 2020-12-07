//
//  MealType+CoreDataProperties.swift
//  RecipeBook
//
//  Created by NORMAND MARTIN on 2020-08-18.
//
//

import Foundation
import CoreData


extension MealType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealType> {
        return NSFetchRequest<MealType>(entityName: "MealType")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var typeImage: String?
    var wrappedType: String {
        type ?? ""
    }
    var wrappedTypeImage: String {
        typeImage ?? ""
    }

}

extension MealType : Identifiable {

}
