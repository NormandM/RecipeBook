//
//  RecipeDetail.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-09.
//

import SwiftUI

struct RecipeDetail: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    var recipe = FetchedResults<Recipe>.Element()
    var type = FetchedResults<MealType>.Element()
    @State var isSheetShown: Bool = false
    @State private var isGeneralInformationShown = false
    @State private var isNutrionFactsShown = false
    @State private var showPhotoScreen = false
    @State private var showingAddScreen = false
    @State private var showAlertDeleteRecipe = false
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    @State private var arrayMealTypes = [String]()
    @State private var recipeViews = [NSLocalizedStringFunc(key:"Main"), NSLocalizedStringFunc(key:"Information"), NSLocalizedStringFunc(key:"Nutrition"), NSLocalizedStringFunc(key:"Photos")]
    @State private var selectorIndex = 0
    var body: some View {

        GeometryReader { geo in
            NavigationLink(destination: AddARecipe(filter: recipe.wrappedName, isNewRecipe: false, typeNumber: arrayMealTypes.firstIndex(of: recipe.wrappedType) ?? 0), isActive: $showingAddScreen) {
                Text("")
            }
            NavigationLink(destination: NutritionInformationView(filter: recipe.wrappedName), isActive: $isNutrionFactsShown) {
                Text("")
            }
            NavigationLink(destination: GeneralInformationView(filter: recipe.wrappedName, recipeURLAdress: recipe.wrappedrecipeURLAdress), isActive: $isGeneralInformationShown) {
                Text("")
            }
            NavigationLink(destination: ThreePhotoView(recipeData: recipe.wrappedPhoto), isActive: $showPhotoScreen) {
                Text("")
            }
            VStack (alignment: .center) {
                Text(recipe.wrappedName)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                Picker("Numbers", selection: $selectorIndex) {
                    ForEach(0 ..< recipeViews.count) { index in
                        Text(self.recipeViews[index]).tag(index)
                    }
                }
                .onChange(of: selectorIndex, perform: {_ in
                    if selectorIndex == 2 {isNutrionFactsShown = true}
                    if selectorIndex == 1 {isGeneralInformationShown = true}
                    if selectorIndex == 3 {showPhotoScreen = true}
                    
                })
                .pickerStyle(SegmentedPickerStyle())
                Text(NSLocalizedStringFunc(key:"Ingredients"))
                ScrollView {
                    Text(recipe.wrappedIngredientf)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)


                }
                .background(Color.white)
                Text(NSLocalizedStringFunc(key:"Preparation"))
                ScrollView {
                    Text(recipe.wrappedPreparation)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

                }
                .background(Color.white)
                Button(action: {
                    showAlertDeleteRecipe = true
                    
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                        Text(NSLocalizedStringFunc(key:"Delete Recipe"))
                            .foregroundColor(.red)
                    }

                }
                
            }
            .padding()
            .navigationBarItems(trailing:
                                    Button(action: {
                                        showingAddScreen = true
                                    }) {
                                        Text(NSLocalizedStringFunc(key:"Edit"))
                                    })
            .padding()
            .background(ColorReference.specialSand)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarColor(UIColorReference.specialGreen)
            .navigationBarTitle(NSLocalizedStringFunc(key:"Recipe"), displayMode: .inline)
            .onAppear{
                for meal in mealTypes {
                    arrayMealTypes.append(meal.wrappedType)
                }
                selectorIndex = 0
                isGeneralInformationShown = false
                isNutrionFactsShown = false
                showPhotoScreen = false
            }
            .alert(isPresented: $showAlertDeleteRecipe){
                Alert(title: Text(NSLocalizedStringFunc(key:"Are you sure you want to delete recipe")), message: Text(NSLocalizedStringFunc(key:"All recipe information will be lost")), primaryButton: .default(Text(NSLocalizedStringFunc(key:"Delete")), action: {
                    deleteRecipe()
                }), secondaryButton: .default(Text(NSLocalizedStringFunc(key:"Keep Recipe")), action: {
                        showAlertDeleteRecipe = false
                }))

            }
            
        }
            
    }
    func deleteRecipe() {
        moc.delete(recipe)
        try? moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    var recipe = FetchedResults<Recipe>.Element()
    static var previews: some View {
        RecipeDetail(isSheetShown: false)
    }
}
