//
//  RecipeDetail.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-09.
//

import SwiftUI
import PDFKit

struct RecipeDetail: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    var recipe: FetchedResults<Recipe>.Element
    
    @State private var image: Image?
    @State private var uiImageRecipe = UIImage()
    @GestureState var scale: CGFloat = 1.0
    @State private var isGeneralInformationShown = false
    @State private var isRecipePreparationShown = false
    @State private var showIngredients = false
    @State private var showingAddScreen = false
    @State private var showAlertDeleteRecipe = false
    @State private var showShareMenu = false
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    @State private var arrayMealTypes = [String]()
    @State private var recipeViews = [NSLocalizedStringFunc(key:"Title"), NSLocalizedStringFunc(key:"Information"), NSLocalizedStringFunc(key:"Ingredients"), NSLocalizedStringFunc(key:"Preparation")]
    @State private var selectorIndex = 0
    @State private var preparationDataIsPresent = false
    @State private var ingredientDataIsPresent = false
    @State private var  ingredientData = Data()
    @State private var  preparationData = Data()
    @State private var activityMonitorIsShowing = false
    
    init(recipe: FetchedResults<Recipe>.Element) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColorReference.specialGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        self.recipe = recipe
    }
    var body: some View {
        GeometryReader { geo in
            if showingAddScreen{
                NavigationLink(destination: AddARecipe(filter: recipe.wrappedName, isNewRecipe: false, typeNumber: arrayMealTypes.firstIndex(of: recipe.wrappedType) ?? 0), isActive: $showingAddScreen) {EmptyView()}
            }else if isRecipePreparationShown {
                NavigationLink(destination: RecipePreparationView(filter: recipe.wrappedName), isActive: $isRecipePreparationShown){EmptyView()}
            }else if isGeneralInformationShown {
                NavigationLink(destination: GeneralInformationView(filter: recipe.wrappedName, recipeURLAdress: recipe.wrappedrecipeURLAdress), isActive: $isGeneralInformationShown) {EmptyView()}
            }else if showIngredients{
                NavigationLink(destination: RecipeIngredientsView(filter: recipe.wrappedName), isActive: $showIngredients) {EmptyView()}
            }
            ZStack {
                ColorReference.specialSand
                VStack () {
                    Picker("Numbers", selection: $selectorIndex) {
                        ForEach(0 ..< recipeViews.count, id: \.self) { index in
                            Text(self.recipeViews[index]).tag(index)
                                .font(.subheadline)
                                .foregroundColor(colorScheme == .light ? .black : .black)
                        }
                    }
                    .onChange(of: selectorIndex, perform: {_ in
                        if selectorIndex == 2 {showIngredients = true; isRecipePreparationShown = false; isGeneralInformationShown = false; showingAddScreen = false}
                        if selectorIndex == 1 {isGeneralInformationShown = true;  isRecipePreparationShown = false;showIngredients = false; showingAddScreen = false}
                        if selectorIndex == 3{isRecipePreparationShown = true;  isGeneralInformationShown = false; showIngredients = false; showingAddScreen = false}
                        
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    Spacer()
                    Text(NSLocalizedStringFunc(key:recipe.wrappedName))
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .foregroundColor(colorScheme == .light ? .black : .black)
                    Spacer()
                    if let unwrappedImage = image {
                        unwrappedImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .border(Color.black, width: 1)
                            .scaleEffect(scale)
                            .frame(height: geo.size.height * 0.4)
                            .gesture(MagnificationGesture()
                                        .updating($scale, body: { (value, scale, trans) in
                                            scale = value.magnitude
                                        })
                            )
                            .zIndex(1)

                    }else{
                        ZStack {
                            Text("There is not picture\nfor this recipe")
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                                .zIndex(1.2)
                            Image("IconeRecipe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .border(Color.black, width: 1)
                                .frame(height: geo.size.height * 0.6)
                        }
                        .background(Color.red)
                    }
                    Spacer()
                    Spacer()

                }
                
            }
            .padding()
            .background(ColorReference.specialSand)
            .navigationBarTitle(NSLocalizedStringFunc(key:"Recipe"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showShareMenu = true
                        activityMonitorIsShowing = true
                        
                    }) {
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.blue)
                                .font(.headline)
                            Text(NSLocalizedStringFunc(key:"Share"))
                                .foregroundColor(.blue)
                                .font(.headline)
                        }
                    }
                    
                }
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showingAddScreen = true
                        isRecipePreparationShown = false
                        isGeneralInformationShown = false
                        showIngredients = false
                        
                    }) {
                        VStack {
                            Image(systemName: "pencil")
                                .foregroundColor(ColorReference.specialGray)
                                .font(.headline)
                            Text(NSLocalizedStringFunc(key:"Edit"))
                                .foregroundColor(ColorReference.specialGray)
                                .font(.headline)
                        }
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showAlertDeleteRecipe = true
                        
                    }) {
                        VStack {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .font(.headline)
                            Text(NSLocalizedStringFunc(key:"Delete"))
                                .foregroundColor(.red)
                                .font(.headline)
                        }
                    }
                }
            }
            .onAppear{
                arrayMealTypes = [String]()
                for meal in mealTypes {
                    arrayMealTypes.append(meal.wrappedType)
                }
                selectorIndex = 0
                isGeneralInformationShown = false
                isRecipePreparationShown = false
                showIngredients = false
                let recipeData = recipe.wrappedPhoto
                if recipeData == Data() {
                    image = Image("IconeRecipe")
                    uiImageRecipe = UIImage(imageLiteralResourceName: "IconeRecipe")
                }else{
                    guard let uiImage = UIImage(data: recipeData) else { return }
                    image = Image(uiImage: uiImage)
                    uiImageRecipe = uiImage
                }

                ingredientData = recipe.wrappedPdfIngredient
                preparationData = recipe.wrappedPdfPreparation
                if ingredientData != Data() {ingredientDataIsPresent = true}
                if preparationData != Data() {preparationDataIsPresent = true}
            }
            .alert(isPresented: $showAlertDeleteRecipe){
                Alert(title: Text(NSLocalizedStringFunc(key:"Are you sure you want to delete recipe")), message: Text(NSLocalizedStringFunc(key:"All recipe information will be lost")), primaryButton: .default(Text(NSLocalizedStringFunc(key:"Delete")), action: {
                    deleteRecipe()
                }), secondaryButton: .default(Text(NSLocalizedStringFunc(key:"Keep Recipe")), action: {
                    showAlertDeleteRecipe = false
                }))

            }
            .sheet(isPresented: $showShareMenu){
                PrintDocument(ingredientData: ingredientData, preparationData: preparationData, imageRecipe: uiImageRecipe, recipeName: recipe.wrappedName, servings: recipe.wrappedServings, preparationtime: recipe.wrappedTimeToPrepare, cookingTime: recipe.wrappedTimeToCook, preparationText: recipe.wrappedPreparation, ingredientText: recipe.wrappedIngredient, ingredientPDfIsPresent: ingredientDataIsPresent, preparationPDFIsPresent: preparationDataIsPresent, activityMonitorIsShowing: $activityMonitorIsShowing)

            }
            if activityMonitorIsShowing{
                WaitingToShare()
                    .position(x: geo.size.width/2, y: geo.size.height/2)
            }
        }
        .navigationBarColor(UIColorReference.specialGreen)
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
    }
    func deleteRecipe() {
        moc.delete(recipe)
        try? moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeDetail(recipe: Recipe())
    }
}
