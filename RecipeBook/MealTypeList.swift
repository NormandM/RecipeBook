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
    var body: some View {
        NavigationView {
                ZStack {
                    if enterNewMealTypeVisible {
                        VStack {
                            Spacer()
                            TextField("Enter New Meal Type", text: $newMealType, onCommit: {
                                UIApplication.shared.endEditing()
                                enterNewMealTypeVisible = false
                                let newType = MealType(context: self.moc)
                                newType.type = self.newMealType
                            })
                            .font(.headline)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(40)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            Button(action: {
                                UIApplication.shared.endEditing()
                                enterNewMealTypeVisible = false
                                let newType = MealType(context: self.moc)
                                newType.type = self.newMealType
                                newType.id = UUID()

                                try? self.moc.save()
                            }){
                               Text("Done")
                            }
                            Spacer()
                        }
                    }else{
                        List {
                            ForEach(mealTypes) { mealType in
                                Text(mealType.wrappedType)
                            }
                            .onDelete(perform: removeMealTypes)
                        }
                        .navigationBarTitle("Edit List", displayMode: .inline)
                        .navigationBarItems(leading: HStack {
                            EditButton()
                            Spacer()
                            Spacer()
                            Button(action: {
                            enterNewMealTypeVisible = true
                            print("ok")
                        }) {
                            Text("Add")
                            }
                        }, trailing:
                            Button("Done"){
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        )
                    }
                }
            }
    }
    private func addRow() {
        
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
