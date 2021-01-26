//
//  TextListView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-25.
//

import SwiftUI

struct TextListView: View {
    var listText: String
    var listImage: String
     init(listText: String, listImage: String) {
        self.listText = listText
        self.listImage = listImage
    }
    var body: some View {
        HStack {
            Text(listText)
                .italic()
                .fontWeight(.light)
                .listRowBackground(ColorReference.specialSand)
                .edgesIgnoringSafeArea(.all)
            Spacer()
            Image(categoryImage())
                .resizable()
                .scaledToFit()
                .frame(width: 50.0, height: 50.0)
            
        }

    }
    func categoryName() -> String{
        let category = ["Appetizer", "Breakfast", "Dessert", "Fish", "Meat", "Pasta", "Poultry", "Salad", "Sauce", "Soup", "Vegetable", "Other"]

        if category.contains(listText){
            return  listText
        }else{
            return "Other"
        }
        
    }
    func categoryImage() -> String {
        let categoryImage = ["Appetizer", "Breakfast", "Dessert", "Fish", "Meat", "Pasta", "Poultry", "Salad", "Sauce", "Soup", "Vegetable", "Other"]
        if categoryImage.contains(listImage){
            return listImage
        }else{
            return "Other"
        }
    }
}

struct TextListView_Previews: PreviewProvider {
    static var previews: some View {
        TextListView(listText: "", listImage: "")
    }
}
