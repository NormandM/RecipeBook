//
//  RecipePageView.swift
//  RecipeBook
//
//  Created by NORMAND MARTIN on 2020-10-18.
//

import SwiftUI

struct RecipePageView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    var mealTypes: FetchedResults<MealType>
    var body: some View {
        GeometryReader { geo in
            ZStack{
                GeometryReader { geo in
                    TabView {
                        ForEach (0 ..< mealTypes.count) { number in
                            VStack {
                                Label {
                                    Text(NSLocalizedStringFunc(key:mealTypes[number].wrappedType))
                                        .foregroundColor(.primary)
                                        .font(.title)
                                        .padding()
                                } icon: {
                                    if mealTypes[number].wrappedType != ""{
                                        Image(mealTypes[number].wrappedType)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.height * 0.1, height: geo.size.height * 0.1)
                                            .padding()
                                    }
                                }
                                .labelStyle(CustomLabelStyle())
                                .frame(width: geo.size.width, height: geo.size.height * 0.1)
                                List{
                                    FilteredrecipeListView(filter: mealTypes[number].wrappedType)
                                        .environment(\.managedObjectContext, self.moc)
                                }
                                .edgesIgnoringSafeArea(.all)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .navigationBarTitle(NSLocalizedStringFunc(key:"Recipes"), displayMode: .inline)
                }
                .onAppear{
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
            }
        }
        .background(ColorReference.specialCoral)
        .navigationBarColor(UIColorReference.specialGreen)
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
    }
}


struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
    }
}
