//
//  GeneralInformationView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-09-07.
//

import SwiftUI

struct GeneralInformationView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    var fetchRequest: FetchRequest<Recipe>
    var title: String
    @State private var recipeName = ""
    @State private var recipeType = ""
    @State private var imageName = ""
    @State private var chef = ""
    @State private var servings = ""
    @State private var rating = 3
    @State private var calories = ""
    @State private var timeToPrepare = ""
    @State private var timeToCook = ""
    @State private var recipeViews = [NSLocalizedStringFunc(key:"Main"), NSLocalizedStringFunc(key:"Information"), NSLocalizedStringFunc(key:"Ingredients"), NSLocalizedStringFunc(key:"Preparation")]
    var recipeURLAdress: String
    @GestureState var scale: CGFloat = 1.0
    @State private var image: Image?
    init(filter: String, recipeURLAdress: String) {
        self.fetchRequest = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
        self.title = filter
        self.recipeURLAdress = recipeURLAdress
    }
    var body: some View {
        GeometryReader{ geo in
            VStack {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(colorScheme == .light ? .black : .black)                        .padding(.leading)
                    .padding(.trailing)
                List{
                    Section(header: SectionHeader(text: NSLocalizedStringFunc(key: "Basic Information"))) {
                        HStack {
                            Text(NSLocalizedStringFunc(key:"Category: "))
                            VStack {
                                Label {
                                    Text(NSLocalizedStringFunc(key:recipeType))
                                } icon: {
                                    Image(imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.height * 0.05, height: geo.size.height * 0.05)
                                        .padding(.trailing)
                                }
                                .labelStyle(CustomLabelStyle())
                            }
                        }
                    }
                    HStack {
                        Text(NSLocalizedStringFunc(key:"Chef: "))
                        Text(chef)
                    }
                    HStack {
                        RatingView(rating: $rating, isInteractif: false)
                    }
                    HStack {
                        Text(NSLocalizedStringFunc(key:"Servings"))
                        Text(servings)
                    }
                    HStack{
                        Text(NSLocalizedStringFunc(key:"Preparation Time: "))
                        Text(timeToPrepare)
                    }
                    HStack{
                        Text(NSLocalizedStringFunc(key:"Cooking time: "))
                        Text(timeToCook)
                    }
                    HStack {
                        Text(NSLocalizedStringFunc(key:"Website: "))
                        if recipeURLAdress == "" {
                            Text("")
                        }else{
                            Link(recipeURLAdress, destination: URL(string: recipeURLAdress)!)
                                .foregroundColor(.blue)
                        }
                    }
                    Section(header: SectionHeader(text: "Nutrition")) {
                        Group {
                            HStack {
                                Text(NSLocalizedStringFunc(key:"Calories: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedCalories)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Total Fat: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedTotalFat)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Trans Fat: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedTransFat)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Saturated Fat: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedSaturatedFat)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Cholesterol: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedCholesterol)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Sodium: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedSodium)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Carbohydrate: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedCarbohydrate)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Sugar: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedSugar)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Protein: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedProtein)
                                }
                            }
                            HStack{
                                Text(NSLocalizedStringFunc(key:"Vitamin D: "))
                                ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                    Text(recipe.wrappedVitaminD)
                                }
                            }
                        }
                        HStack{
                            Text(NSLocalizedStringFunc(key:"Calcium: "))
                            ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                Text(recipe.wrappedCalcium)
                            }
                        }
                        HStack{
                            Text(NSLocalizedStringFunc(key:"Iron: "))
                            ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                Text(recipe.wrappedIron)
                            }
                        }
                        HStack{
                            Text(NSLocalizedStringFunc(key:"Potassium: "))
                            ForEach(fetchRequest.wrappedValue, id: \.self){recipe in
                                Text(recipe.wrappedPotassium)
                            }
                        }
                    }
                    
                }
                .frame(alignment: .center)
            }
            .onAppear{
                for recipes in fetchRequest.wrappedValue {
                    recipeName = recipes.wrappedName
                    recipeType = recipes.wrappedType
                    imageName = recipes.wrappedImageName
                    chef = recipes.wrappedChef
                    rating = Int(recipes.rating)
                    servings = recipes.wrappedServings
                    calories = recipes.wrappedCalories
                    timeToCook = recipes.wrappedTimeToCook
                    timeToPrepare = recipes.wrappedTimeToPrepare
                }
            }
            .navigationBarTitle(NSLocalizedStringFunc(key:"Recipe Info"), displayMode: .inline)
            .navigationBarColor(UIColorReference.specialGreen)
            .background(ColorReference.specialSand)
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            
        }
    }
}

//struct GeneralInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        GeneralInformationView(filter: "", recipeURLAdress: "")
//    }
//}
