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
    var mealTypes: FetchedResults<MealType>
    @State private var newMealType = ""
    @State private var enterNewMealTypeVisible = false
    @State private var textFieldChanged = false
    @State private var textFieldPlaceHolder = NSLocalizedStringFunc(key:"Enter New Meal Category")
    @State private var arrayMealTypes = [String]()
    @State private var showAlertSameName = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                NewMealTypeView(newMealType: $newMealType)
                    .opacity(enterNewMealTypeVisible ? 1.0 : 0.0)
            }
            .zIndex(1.0)
            List {
                ForEach(mealTypes, id: \.self) { mealType in
                    TextListView(listText: NSLocalizedStringFunc(key:mealType.wrappedType), listImage: mealType.wrappedTypeImage)
                }
                .onDelete(perform: removeMealTypes)
            }
            .blur(radius: enterNewMealTypeVisible  ?  50 : 0.0)
          //  .navigationBarBackButtonHidden(true)
            .navigationBarTitle(NSLocalizedStringFunc(key:"Meal Types"), displayMode: .large)
            .navigationBarItems(leading: HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {

                }
                if enterNewMealTypeVisible {
                    Button(action: {
                        enterNewMealTypeVisible = false
                    }) {
                        Text("Cancel")
                            .font(.headline)
                    }
                }else{
                    EditButton()
                        .font(.headline)
                        .padding()
                }
                
            }, trailing:
                HStack {
                    if enterNewMealTypeVisible {
                        Button(action: {
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
                            
                        }) {
                            Text("Save")
                                .font(.headline)
                        }
                    }else{
                        Button(action: {
                            add()
                        }){
                            Image(systemName: "plus")
                                .font(.headline)
                        }
                    }
                })
        }
        .phoneOnlyStackNavigationView()
        .navigationBarColor(UIColorReference.specialGreen)
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        .alert(isPresented: $showAlertSameName) {
            Alert(title: Text(NSLocalizedStringFunc(key:"This category alerady exist")), dismissButton: .default(Text(NSLocalizedStringFunc(key:"Ok"))))
        }

        .onAppear{
            Duplicates.remove(mealTypes: mealTypes, moc: moc)
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
    func add() {
        withAnimation(.linear(duration: 3.0)) {
            enterNewMealTypeVisible = true
        }
        textFieldPlaceHolder = NSLocalizedStringFunc(key:"Enter New Meal Category")
        textFieldChanged = true
    }

}


//struct mealTypeList_Previews: PreviewProvider {
//    static var previews: some View {
//        MealTypeList(mealTypes: <#FetchedResults<MealType>#>)
//    }
//}
