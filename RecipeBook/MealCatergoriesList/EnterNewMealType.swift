//
//  EnterNewMealType.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-11-08.
//

import SwiftUI

struct EnterNewMealType: View {
    @Binding var newMealType: String
    @State private var enterNewMealTypeVisible: Bool = false
    @State private var opaci = 0.0
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ColorReference.specialSand
                VStack {
                Image("IconeRecipe")
                    .resizable()
                    .frame(width: geo.size.height/2.4, height: geo.size.height/2.4)
                    .cornerRadius(25)
               
                    TextField(NSLocalizedStringFunc(key:"Enter New Meal Category"), text: $newMealType, onCommit: {
                        UIApplication.shared.endEditing()
                    })
                    .frame(width: geo.size.height/2.0)
                    .background(Color(.white))
                    .padding()
                    
                }
                .frame(width: geo.size.height/2.4, height: geo.size.height/2.4, alignment: .center)
                .opacity(self.enterNewMealTypeVisible ? 1.0 : 0.0)

                
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .navigationBarColor(UIColorReference.specialGreen)
            .onAppear{
                withAnimation(.linear(duration: 3.0)) {
                    self.enterNewMealTypeVisible = true
                }

            }
            
        }
        
    }
}

//struct EnterNewMealType_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterNewMealType(categoryName: $categoryName)
//    }
//}
