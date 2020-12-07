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
    @FetchRequest(entity: MealType.entity(), sortDescriptors: []) var mealTypes: FetchedResults<MealType>
    @State private var hasChanged = false
    var body: some View {
        GeometryReader { geo in
            ZStack{
                TabView {
                    ForEach (0 ..< mealTypes.count) { number in
                        VStack {
                            Label {
                                Text(mealTypes[number].wrappedType)
                                    .foregroundColor(.primary)
                                    .font(.largeTitle)
                                    .padding()
                                Text(hasChanged ? "" : "")
                                
                                
                            } icon: {
                                if mealTypes[number].wrappedType != ""{
                                    Image(mealTypes[number].wrappedTypeImage)
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
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .navigationBarTitle(NSLocalizedStringFunc(key:"RECIPES"), displayMode: .inline)
            }
            .onAppear{
                hasChanged = true
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            }
        }
        .background(ColorReference.specialCoral)
        .ignoresSafeArea()
        .navigationBarColor(UIColorReference.specialGreen)
    }
}

struct RecipePageView_Previews: PreviewProvider {
    static var previews: some View {
        RecipePageView()
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
