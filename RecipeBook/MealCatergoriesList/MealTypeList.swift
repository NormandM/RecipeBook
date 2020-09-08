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
    @FetchRequest(entity: MealType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MealType.type, ascending: true)]) var mealTypes: FetchedResults<MealType>
    @State private var newMealType = ""
    @State private var enterNewMealTypeVisible = false
    @State private var textFieldChanged = false
    @State private var textFieldPlaceHolder = "Enter New Meal Category"
    init() {
        UITableView.appearance().backgroundColor = UIColorReference.specialSand
     
    
            // this is not the same as manipulating the proxy directly
            let appearance = UINavigationBarAppearance()
            
            // this overrides everything you have set up earlier.
            appearance.configureWithTransparentBackground()
            
            // this only applies to big titles
            appearance.largeTitleTextAttributes = [
                .font : UIFont.systemFont(ofSize: 20),
                NSAttributedString.Key.foregroundColor : UIColorReference.specialDarkBrown
            ]
            // this only applies to small titles
            appearance.titleTextAttributes = [
                .font : UIFont(name:"Papyrus", size: 25)!,
                NSAttributedString.Key.foregroundColor : UIColorReference.specialDarkBrown,
            ]
            
            //In the following two lines you make sure that you apply the style for good
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
            
            // This property is not present on the UINavigationBarAppearance
            // object for some reason and you have to leave it til the end
            UINavigationBar.appearance().tintColor = .systemBlue
            
        }
    var body: some View {
                ZStack {
                    if enterNewMealTypeVisible {
                        VStack {
                            Spacer()
                            TextField(textFieldPlaceHolder, text: $newMealType, onCommit: {
                                UIApplication.shared.endEditing()
                                    
                                enterNewMealTypeVisible = false
                                let newType = MealType(context: self.moc)
                                newType.type = self.newMealType
                            })
                            .font(.headline)
                            .foregroundColor(ColorReference.specialDarkBrown)
                            .padding()
                            .background(ColorReference.specialGray)
                            .cornerRadius(40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            Spacer()
                        }
                        .background(ColorReference.specialSand)
                    }else{
                        List {
                            ForEach(mealTypes) { mealType in
                                TextListView(listText: mealType.wrappedType)
                            }

                            .onDelete(perform: removeMealTypes)
                        }
                        .navigationBarTitle("Edit List", displayMode: .inline)
                        .navigationBarColor(UIColorReference.specialGreen)
                        .navigationBarItems(leading: HStack {
                            EditButton()
                            Spacer()
                            Spacer()
                            Button(action: {
                            enterNewMealTypeVisible = true
                            textFieldPlaceHolder = "Enter New Meal Category"
                            textFieldChanged = true
                           
                        }) {
                            Text("Add")
                            }
                        }, trailing:
                            
                            Button("Done"){
                                if textFieldChanged {
                                    UIApplication.shared.endEditing()
                                    enterNewMealTypeVisible = false
                                    let newType = MealType(context: self.moc)
                                    newType.type = self.newMealType
                                    newType.id = UUID()
                                    try? self.moc.save()
                                    textFieldChanged = false
                                }else{
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                
                                
                            }
                            
                            
                        )
                    }
                }

    }
    func removeMealTypes(at offsets: IndexSet) {
        for index in offsets {
            let mealType = mealTypes[index]
            moc.delete(mealType)
        }
        try? moc.save()
    }
}

struct mealTypeList_Previews: PreviewProvider {
    static var previews: some View {
        MealTypeList()
    }
}
