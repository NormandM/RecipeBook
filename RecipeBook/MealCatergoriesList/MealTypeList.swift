//
//  mealTypeList.swift
//  RecipeBook
//
//  Created by NORMAND MARTIN on 2020-08-18.
//

import SwiftUI

struct MealTypeList: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    var mealTypes: FetchedResults<MealType>
    @State private var newMealType = ""
    @State private var enterNewMealTypeVisible = false
    @State private var textFieldChanged = false
    @State private var textFieldPlaceHolder = NSLocalizedStringFunc(key:"Enter New Meal Category")
    @State private var arrayMealTypes = [String]()
    @State private var showAlertSameName = false
    var body: some View {
                ZStack {
                    if enterNewMealTypeVisible {
                        EnterNewMealType(newMealType: $newMealType)
                            .zIndex(1.0)
                    }else{
                        List {
                            ForEach(mealTypes) { mealType in
                                TextListView(listText: mealType.wrappedType, listImage: mealType.wrappedTypeImage)
                            }
                            .onDelete(perform: removeMealTypes)
                        }
                        .blur(radius: enterNewMealTypeVisible  ?  75 : 0.0)
                        .navigationBarTitle(NSLocalizedStringFunc(key:"Edit List"), displayMode: .inline)
                        .navigationBarColor(UIColorReference.specialGreen)
                        .navigationBarItems(leading: HStack {
                            EditButton()
                            Spacer()
                            Spacer()
                            Button(action: {
                            enterNewMealTypeVisible = true
                                textFieldPlaceHolder = NSLocalizedStringFunc(key:"Enter New Meal Category")
                            textFieldChanged = true
                           
                        }) {
                                Text(NSLocalizedStringFunc(key:"Add"))
                            }
                        }, trailing:
                            Button(NSLocalizedStringFunc(key:"Save")){
                                if textFieldChanged && !checkForSameName() {
                                    UIApplication.shared.endEditing()
                                    enterNewMealTypeVisible = false
                                    let newType = MealType(context: self.moc)
                                    newType.type = self.newMealType
                                    newType.id = UUID()
                                    try? self.moc.save()
                                    textFieldChanged = false
                                }else{
                                    showAlertSameName = true
                                }
                            }
 
                        )
                    }
                   
                }
                
                    .zIndex(-0.5)
                .onAppear{
//                    for meal in mealTypes {
//                        arrayMealTypes.append(meal.wrappedType)
//                        print(meal.wrappedType)
//                    }
//                    print(arrayMealTypes.count)
//                    if arrayMealTypes.count == 0 {
//                        UserDefaults.standard.set(true, forKey: "First Lauch")
//                        let newMealCategory = MealType(context: self.moc)
//                        newMealCategory.id = UUID()
//                        newMealCategory.type = NSLocalizedStringFunc(key:"Appetizer")
//                        newMealCategory.typeImage = "Appetizer"
//                        let newMealCategory2 = MealType(context: self.moc)
//                        newMealCategory2.id = UUID()
//                        newMealCategory2.type = NSLocalizedStringFunc(key:"Breakfast")
//                        newMealCategory2.typeImage = "Breakfast"
//                        let newMealCategory3 = MealType(context: self.moc)
//                        newMealCategory3.id = UUID()
//                        newMealCategory3.type = NSLocalizedStringFunc(key:"Dessert")
//                        newMealCategory3.typeImage = "Dessert"
//                        let newMealCategory4 = MealType(context: self.moc)
//                        newMealCategory4.id = UUID()
//                        newMealCategory4.type = NSLocalizedStringFunc(key:"Fish")
//                        newMealCategory4.typeImage = "Fish"
//                        let newMealCategory5 = MealType(context: self.moc)
//                        newMealCategory5.id = UUID()
//                        newMealCategory5.type = NSLocalizedStringFunc(key:"Meat")
//                        newMealCategory5.typeImage = "Meat"
//                        let newMealCategory6 = MealType(context: self.moc)
//                        newMealCategory6.id = UUID()
//                        newMealCategory6.type = NSLocalizedStringFunc(key:"Other")
//                        newMealCategory6.typeImage = "Other"
//                        let newMealCategory7 = MealType(context: self.moc)
//                        newMealCategory7.id = UUID()
//                        newMealCategory7.type = NSLocalizedStringFunc(key:"Pasta")
//                        newMealCategory7.typeImage = "Pasta"
//                        let newMealCategory8 = MealType(context: self.moc)
//                        newMealCategory8.id = UUID()
//                        newMealCategory8.type = NSLocalizedStringFunc(key:"Poultry")
//                        newMealCategory8.typeImage = "Poultry"
//                        let newMealCategory9 = MealType(context: self.moc)
//                        newMealCategory9.id = UUID()
//                        newMealCategory9.type = NSLocalizedStringFunc(key:"Salad")
//                        newMealCategory9.typeImage = "Salad"
//                        let newMealCategory10 = MealType(context: self.moc)
//                        newMealCategory10.id = UUID()
//                        newMealCategory10.type = NSLocalizedStringFunc(key:"Sauce")
//                        newMealCategory10.typeImage = "Sauce"
//                        let newMealCategory11 = MealType(context: self.moc)
//                        newMealCategory11.id = UUID()
//                        newMealCategory11.type = NSLocalizedStringFunc(key:"Soup")
//                        newMealCategory11.typeImage = "Soup"
//                        let newMealCategory12 = MealType(context: self.moc)
//                        newMealCategory12.id = UUID()
//                        newMealCategory12.type = NSLocalizedStringFunc(key:"Vegetable")
//                        newMealCategory12.typeImage = "Vegetable"
//                        try? self.moc.save()
//                    }
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .alert(isPresented: $showAlertSameName) {
                    Alert(title: Text(NSLocalizedStringFunc(key:"This category alerady exist")), dismissButton: .default(Text(NSLocalizedStringFunc(key:"Ok"))))
                }
    }
    func removeMealTypes(at offsets: IndexSet) {
        for index in offsets {
            let mealType = mealTypes[index]
            moc.delete(mealType)
        }
        try? moc.save()
    }
    func checkForSameName() -> Bool{
        if arrayMealTypes.contains(newMealType) {
            
            return true
        }else{
            return false
        }
    }
}

//struct mealTypeList_Previews: PreviewProvider {
//    static var previews: some View {
//        MealTypeList(mealTypes: <#FetchedResults<MealType>#>)
//    }
//}
