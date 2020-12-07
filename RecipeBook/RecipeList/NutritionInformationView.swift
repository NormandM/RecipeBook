//
//  NutritionInformationView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-09-07.
//

import SwiftUI

struct NutritionInformationView: View {
    @Environment(\.managedObjectContext) var moc
    var fetchRequest: FetchRequest<Recipe>
    var title: String
    init(filter: String) {
        self.fetchRequest = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
        self.title = filter
    }
    
    var body: some View {
        GeometryReader { geo in
                VStack{
                    Text(title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding(.leading)
                        .padding(.trailing)
                    List {
                        Group {
                            HStack {
                                Text(NSLocalizedStringFunc(key:"Calories: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedCalories)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Total Fat: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedTotalFat)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Trans Fat: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedTransFat)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Saturated Fat: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedSaturatedFat)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Colesterol: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedCholesterol)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Sodium: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedSodium)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Carbohydrate: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedCarbohydrate)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Sugar: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedSugar)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Protein: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedProtein)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Vitamin D: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedVitaminD)
                                }
                            }
                        }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Calcium: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedCalcium)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Iron: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedIron)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Potassium: "))
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedPotassium)
                                }
                            }
                    }
                    .frame(alignment: .center)

                }

                
            }
        .navigationBarTitle(NSLocalizedStringFunc(key:"Nutritional Facts"), displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .background(ColorReference.specialSand)
        .edgesIgnoringSafeArea(.bottom)



    }
}

struct NutritionInformationView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionInformationView(filter: "")
    }
}
