//
//  SectionRow.swift
//  RecipeBook
//
//  Created by NORMAND MARTIN on 2020-08-23.
//

import SwiftUI

struct SectionRow: View {
    var fetchRequestMealType: FetchRequest<MealType>
    init(filter: String) {
        fetchRequestMealType = FetchRequest<MealType>(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)] ,predicate: NSPredicate(format: "type == %@", filter))
    }
    var body: some View {
//        List (fetchRequestMealType.wrappedValue){mealType in
//            Text(mealType.wrappedType)
//                .background(Color.orange)
//
//        }
        ForEach(fetchRequestMealType.wrappedValue){mealType in
            Text(mealType.wrappedType)
        }
        
    }
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SectionRow(filter: "")
    }
}
