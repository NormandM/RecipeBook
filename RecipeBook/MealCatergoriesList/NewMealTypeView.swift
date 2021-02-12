//
//  NewMealTypeView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-01-02.
//

import SwiftUI

struct NewMealTypeView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var newMealType: String
    @State private var opaci = 0.0
    @State private var scaleforTrait: CGFloat = 0.0
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack {

                    TextField(NSLocalizedStringFunc(key:"Enter New Meal Category"), text: $newMealType, onCommit: {
                        UIApplication.shared.endEditing()
                    })
                    .padding()
                    .frame(width: geo.size.height/scaleView(), alignment: .center)
                    .background(colorScheme == .light ? ColorReference.specialSand : ColorReference.specialDarkBrown)
                    .cornerRadius(25)
                    .padding()
                    Image("IconeRecipe")
                        .resizable()
                        .frame(width: geo.size.height/scaleView(), height: geo.size.height/scaleView())
                        .cornerRadius(25)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .navigationBarColor(UIColorReference.specialGreen)
        }
    }
    func scaleView() -> CGFloat {
        var scaleConstant: CGFloat = 0.0
        if self.verticalSizeClass == .compact {
            scaleConstant = 1.5
        } else {
            scaleConstant = 2.4
        }
        return scaleConstant
    }
}

//struct NewMealTypeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewMealTypeView(newMealType: $newMealType)
//    }
//}
