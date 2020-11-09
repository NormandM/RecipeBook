//
//  GeneralInformationView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-09-07.
//

import SwiftUI

struct GeneralInformationView: View {
    @Environment(\.managedObjectContext) var moc
    var fetchRequest: FetchRequest<Recipe>
    var title: String
    @State private var recipeType = ""
    @State private var chef = ""
    @State private var servings = ""
    @State private var rating = 3
    @State private var calories = ""
    @State private var timeToPrepare = ""
    @State private var timeToCook = ""
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
            NavigationView{
                VStack {
                    Text(title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding(.leading)
                        .padding(.trailing)
                    List{
                        HStack {
                            Text("Categorie: ")
                            VStack {
                                Label {
                                    Text(recipeType)
                                } icon: {
                                    Image(recipeType)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.height * 0.05, height: geo.size.height * 0.05)
                                        .padding(.trailing)
                                }
                                .labelStyle(CustomLabelStyle())
                            }
                        }
                        HStack {
                            Text("Chef: ")
                            Text(chef)
                        }
                        HStack {
                            RatingView(rating: $rating, isInteractif: false)
                        }
                        HStack {
                            Text("Servings")
                            Text(servings)
                        }
                        HStack {
                            Text("Calories per Serving")
                            Text(calories)
                        }
                        
                        HStack{
                            Text("Time to prepare: ")
                            Text(timeToPrepare)
                        
                        }
                        HStack{
                            Text("Time to cook: ")
                            Text(timeToCook)
                        }
                        HStack {
                            Text("Recipe website address: ")
                            if recipeURLAdress == "" {
                                Text("This recipe is not from the web")
                            }else{
                                Link(recipeURLAdress, destination: URL(string: recipeURLAdress)!)
                            }

                        }
                        
                    }
                    .frame(alignment: .center)

                    
                }
                .onAppear{
                    print(fetchRequest.wrappedValue)
                    for recipes in fetchRequest.wrappedValue {
                        recipeType = recipes.wrappedType
                        chef = recipes.wrappedChef
                        rating = Int(recipes.rating)
                        servings = recipes.wrappedServings
                        calories = recipes.wrappedCalories
                        timeToCook = recipes.wrappedTimeToCook
                        timeToPrepare = recipes.wrappedTimeToPrepare
                        //"recipeURLAdress = recipes.wrappedrecipeURLAdress
                        print(rating)
                    }
                }
                
                .navigationBarTitle("Recipe Facts", displayMode: .inline)
                .navigationBarColor(UIColorReference.specialGreen)
                .background(ColorReference.specialSand)
                .edgesIgnoringSafeArea(.bottom)
                
            }
        }
    }
}

struct GeneralInformationView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralInformationView(filter: "", recipeURLAdress: "")
    }
}
