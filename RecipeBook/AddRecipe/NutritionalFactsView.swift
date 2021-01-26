//
//  NutritionalFactsView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-09-01.
//

import SwiftUI

struct NutritionalFactsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var savedValue: SavedValue
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
    
    var existingcalciumRecipe: String
    var existingCaloriesRecipe: String
    var existingCarbohydrateRecipe: String
    var existingCholesterolRecipe: String
    var existingIronRecipe: String
    var existingPotassiumRecipe: String
    var existingProteinRecipe: String
    var existingSaturatedFatRecipe: String
    var existingSodiumRecipe: String
    var existingTotalFatRecipe: String
    var existingTransFatRecipe: String
    var existingVitaminDRecipe: String
    var existingSugarRecipe: String
    var body: some View {
        Form{
            Section {
            Text("Amount per Serving")
            }
            Section {
                TextField(NSLocalizedStringFunc(key:"Calories"), text: $caloriesRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: caloriesRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Total Fat"), text: $totalFatRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: totalFatRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Trans Fat"), text: $transFatRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: transFatRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Saturated Fat"), text: $saturatedFatRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: saturatedFatRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Cholesterol"), text: $cholesterolRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: cholesterolRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Sodium"), text: $sodiumRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: sodiumRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Carbohydrate"), text: $carbohydrateRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: carbohydrateRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Sugar"), text: $sugarRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: sugarRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Protein"), text: $proteinRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: proteinRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })

            }
            Section {
                TextField(NSLocalizedStringFunc(key:"Vitamin D"), text: $vitaminDRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: vitaminDRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Calcium"), text: $calciumRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: calciumRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Iron"), text: $ironRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: ironRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })
                TextField(NSLocalizedStringFunc(key:"Potassium"), text: $potassiumRecipe, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .onChange(of: potassiumRecipe, perform: { newValue in
                    savedValue.recipeSaved = false
                })

            }
        }
        .onAppear{
            if existingcalciumRecipe != "" {
                calciumRecipe = existingcalciumRecipe
            }
            if existingCaloriesRecipe != "" {
                caloriesRecipe = existingCaloriesRecipe
            }
            if existingCarbohydrateRecipe != "" {
                carbohydrateRecipe = existingCarbohydrateRecipe
            }
            if existingCholesterolRecipe != "" {
                cholesterolRecipe = existingCholesterolRecipe
            }
            if existingIronRecipe != "" {
                ironRecipe = existingIronRecipe
            }
            if existingPotassiumRecipe != "" {
                potassiumRecipe = existingPotassiumRecipe
            }
            if existingProteinRecipe != "" {
                proteinRecipe = existingProteinRecipe
            }
            if existingSaturatedFatRecipe != "" {
                saturatedFatRecipe = existingSaturatedFatRecipe
            }
            if existingSodiumRecipe != "" {
                sodiumRecipe = existingSodiumRecipe
            }
            if existingTotalFatRecipe != "" {
                totalFatRecipe = existingTotalFatRecipe
            }
            if existingTransFatRecipe != "" {
                transFatRecipe = existingTransFatRecipe
            }
            if existingVitaminDRecipe != "" {
                vitaminDRecipe = existingVitaminDRecipe
            }
            if existingSugarRecipe != "" {
                sugarRecipe = existingSugarRecipe
            }
        }
        .navigationBarTitle(NSLocalizedStringFunc(key:"Nutritional Infos"), displayMode: .inline)
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
                Text(NSLocalizedStringFunc(key:"Back"))
            }
        })
    }
}

//struct NutritionalFactsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NutritionalFactsView(calcium: .constant(""), calories: .constant(""), carbohydrate: .constant(""), cholesterol: .constant(""), iron: .constant(""), potassium: .constant(""), protein: .constant(""), saturatedFat: .constant(""), sodium: .constant(""), totalFat: .constant(""), transFat: .constant(""), vitaminD: .constant(""), sugar: .constant(""))
//    }
//}
