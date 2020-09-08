//
//  TextListView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-25.
//

import SwiftUI

struct TextListView: View {
    var listText: String
     init(listText: String) {
        self.listText = listText
        
    }
    var body: some View {
        HStack {
            Text(listText)
                .italic()
                .fontWeight(.light)
                .listRowBackground(ColorReference.specialSand)
                .edgesIgnoringSafeArea(.all)
            Spacer()
            Image(categoryName())
                .resizable()
                .scaledToFit()
                .frame(width: 50.0, height: 50.0)
            
        }

    }
    func categoryName() -> String{
        let category = ["Appetizers", "Bakery", "Breakfast", "Desserts", "Fish", "Meat", "Other", "Pasta", "Poultry", "Salads", "Sauces", "Soups"]
        if category.contains(listText){
            return listText
        }else{
            return "Other"
        }
        
    }
}

struct TextListView_Previews: PreviewProvider {
    static var previews: some View {
        TextListView(listText: "")
    }
}
