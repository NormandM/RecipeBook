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
    @State private var rating = 3
    @GestureState var scale: CGFloat = 1.0
    @State private var image: Image?
    init(filter: String) {
        self.fetchRequest = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
        self.title = filter
    }
    
    
    var body: some View {
        GeometryReader{ geo in
            NavigationView{
                VStack {
                    Text(title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding(.bottom)
                        .padding(.leading)
                        .padding(.trailing)
                    List{
                        HStack {
                            Text("Categorie: ")
                            ForEach(fetchRequest.wrappedValue){recipe in
                                Text(recipe.wrappedType)
                            }
                        }
                        HStack {
                            Text("Chef: ")
                            ForEach(fetchRequest.wrappedValue){recipe in
                                Text(recipe.wrappedChef)
                            }
                        }
                        HStack {
                            Text("Rating: ")
                            ForEach(fetchRequest.wrappedValue){recipe in
                                RatingView(rating: $rating)
                            }
                        }
                        HStack {
                            Text("Servings")
                            ForEach(fetchRequest.wrappedValue){recipe in
                                Text(String(recipe.servings))
                            }
                        }
                        HStack {
                            Text("Calories per Serving")
                            ForEach(fetchRequest.wrappedValue){recipe in
                                Text(recipe.wrappedCalories)
                            }
                        }
                        
                        HStack{
                            Text("Time to prepare: ")
                            ForEach(fetchRequest.wrappedValue){recipe in
                                Text(recipe.wrappedTimeToPrepare)
                            }
                        }
                        HStack{
                            Text("Time to cook: ")
                            ForEach(fetchRequest.wrappedValue){recipe in
                                Text(recipe.wrappedTimeToCook)
                            }
                        }
                        
                    }
                    .frame(width: geo.size.height * 0.5, height: geo.size.height * 0.5, alignment: .center)
                    .border(Color.black, width: 1)
                    
                }
                .onAppear{
                    for recipes in fetchRequest.wrappedValue {
                        rating = Int(recipes.rating)
                    }
                }
                
                .navigationBarTitle("Recipe Facts", displayMode: .inline)
                .navigationBarColor(UIColorReference.specialGreen)
                .background(ColorReference.specialSand)
                
            }
        }
    }
}

struct GeneralInformationView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralInformationView(filter: "")
    }
}
