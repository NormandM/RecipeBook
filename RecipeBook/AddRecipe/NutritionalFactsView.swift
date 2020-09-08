//
//  NutritionalFactsView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-09-01.
//

import SwiftUI

struct NutritionalFactsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var calcium: String
    @Binding var calories: String
    @Binding var carbohydrate: String
    @Binding var cholesterol: String
    @Binding var iron: String
    @Binding var potassium: String
    @Binding var protein: String
    @Binding var saturatedFat: String
    @Binding var sodium: String
    @Binding var totalFat: String
    @Binding var transFat: String
    @Binding var vitaminD: String
    @Binding var sugar: String
    @State private var calciumRecipe = ""
    @State private var caloriesRecipe = ""
    @State private var carbohydrateRecipe = ""
    @State private var cholesterolRecipe = ""
    @State private var ironRecipe = ""
    @State private var potassiumRecipe = ""
    @State private var proteinRecipe = ""
    @State private var saturatedFatRecipe = ""
    @State private var sodiumRecipe = ""
    @State private var totalFatRecipe = ""
    @State private var transFatRecipe = ""
    @State private var vitaminDRecipe = ""
    @State private var sugarRecipe = ""
    var body: some View {
        Form{
            Section {
            Text("Amount per Serving")
            }
            Section {
                TextField("Calories", text: $caloriesRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Total Fat", text: $totalFatRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Trans Fat", text: $transFatRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Saturated Fat", text: $saturatedFatRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Cholesterol", text: $cholesterolRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Sodium", text: $sodiumRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Carbohydrate", text: $carbohydrateRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Sugar", text: $sugarRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Protein", text: $proteinRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })

            }
            Section {
                TextField("Vitamin D", text: $vitaminDRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Calcium", text: $calciumRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Iron", text: $ironRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                TextField("Potassium", text: $potassiumRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })

            }
        }
        .navigationBarTitle("Nutrition Facts", displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
          Button(action: {
            self.calcium = calciumRecipe
            self.calories = caloriesRecipe
            self.carbohydrate = carbohydrateRecipe
            self.cholesterol = cholesterolRecipe
            self.iron = ironRecipe
            self.potassium = potassiumRecipe
            self.protein = proteinRecipe
            self.saturatedFat = saturatedFatRecipe
            self.sodium = sodiumRecipe
            self.totalFat = totalFatRecipe
            self.transFat = transFatRecipe
            self.vitaminD = vitaminDRecipe
            self.sugar = sugarRecipe
            self.presentationMode.wrappedValue.dismiss()
          }) {
            HStack {
              Image(systemName: "chevron.left")
              Text("Back")
            }
        })
    }
}

struct NutritionalFactsView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionalFactsView(calcium: .constant(""), calories: .constant(""), carbohydrate: .constant(""), cholesterol: .constant(""), iron: .constant(""), potassium: .constant(""), protein: .constant(""), saturatedFat: .constant(""), sodium: .constant(""), totalFat: .constant(""), transFat: .constant(""), vitaminD: .constant(""), sugar: .constant(""))
    }
}
