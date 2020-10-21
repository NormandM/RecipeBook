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
        GeometryReader { geo in
            ForEach(fetchRequestMealType.wrappedValue){mealType in
                    HStack {
                        
                        
                        Image(mealType.wrappedType)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.height * 0.9, height: geo.size.height * 0.9)
                            .padding(.leading)
                        Text(mealType.wrappedType)
                            .italic()
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    
                            Spacer()
                    }
                .padding(0).background(FillAll(color: ColorReference.specialCoral))
                    
                
            }
            
        }
    }

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SectionRow(filter: "")
    }
}
struct FillAll: View {
    let color: Color

    var body: some View {
        GeometryReader { proxy in
            self.color.frame(width: proxy.size.width * 1.3, height: proxy.size.height * 1.2).fixedSize()
        }
    }
}
