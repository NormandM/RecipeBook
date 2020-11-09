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
            NavigationView{
                VStack{
                    Text(title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding(.leading)
                        .padding(.trailing)
                    List {
                        Group {
                            HStack {
                                Text("Calories: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedCalories)
                                }
                            }
                            HStack{
                                Text("Total Fat: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedTotalFat)
                                }
                            }
                            HStack{
                                Text("Trans Fat: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedTransFat)
                                }
                            }
                            HStack{
                                Text("Saturated Fat: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedSaturatedFat)
                                }
                            }
                            HStack{
                                Text("Colesterol: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedCholesterol)
                                }
                            }
                            HStack{
                                Text("Sodium: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedSodium)
                                }
                            }
                            HStack{
                                Text("Carbohydrate: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedCarbohydrate)
                                }
                            }
                            HStack{
                                Text("Sugar: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedSugar)
                                }
                            }
                            HStack{
                                Text("Protein: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedProtein)
                                }
                            }
                            HStack{
                                Text("Vitamin D: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedVitaminD)
                                }
                            }
                        }
                            HStack{
                                Text("Calcium: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedCalcium)
                                }
                            }
                            HStack{
                                Text("Iron: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedIron)
                                }
                            }
                            HStack{
                                Text("Potassium: ")
                                ForEach(fetchRequest.wrappedValue){recipe in
                                    Text(recipe.wrappedPotassium)
                                }
                            }
                    }
                    .frame(alignment: .center)

                }
                .navigationBarTitle("Nutritional Facts", displayMode: .inline)
                .navigationBarColor(UIColorReference.specialGreen)
                .background(ColorReference.specialSand)
                .edgesIgnoringSafeArea(.bottom)
                
            }
        }
    }
}

struct NutritionInformationView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionInformationView(filter: "")
    }
}
