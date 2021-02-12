//
//  ButtonView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-01-13.
//

import SwiftUI
import CoreData

struct ButtonView: View {
    @EnvironmentObject var savedValue: SavedValue
    @State private  var recipeSaved = false
    @State  var showAlertRecipeNotSaved = false
    @State var showAlertSameName = false
    @State var showAlertNoName = false
    @Binding var showAlerts: Bool
    @Binding var activeAlert: ActiveAlert
    @State  var clearDisk: () -> Void
    var recipes: FetchedResults<Recipe>
    var areAllChangesSaved: (FetchedResults<Recipe>) -> ActiveAlert
    var sameName: (FetchedResults<Recipe>) -> ActiveAlert
    var name: String
    var body: some View {
        Button(action: {
            if savedValue.recipeSaved {
                clearDisk()
                recipeSaved = false
                showAlerts = false
                savedValue.recipeSaved = true
            }else{
                activeAlert = sameName(recipes)
                if activeAlert == .showAlertSameName {
                    showAlerts = true
                    showAlertSameName = true
                }
                if name == "" {
                    activeAlert = .showAlertNoName
                    showAlertNoName = true
                    showAlerts = true
                }
                if !(showAlertNoName  || showAlertNoName){
                    activeAlert = areAllChangesSaved(recipes)
                    if activeAlert != ActiveAlert.showAlertRecipeNotSaved{
                        clearDisk()
                        recipeSaved = false
                        showAlerts = false
                        savedValue.recipeSaved = true
                    }
                }
            }
            
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title)
            }
        })
    }
}

//struct ButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonView()
//    }
//}
