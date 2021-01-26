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
                    print("2")
                    showAlerts = true
                    showAlertSameName = true
                }
                print("name: \(name)")
                if name == "" {
                    print("3")
                    activeAlert = .showAlertNoName
                    showAlertNoName = true
                    showAlerts = true
                }
                print("showAlertNoName: \(showAlertNoName)")
                print("showAlertSameName: \(showAlertSameName)")
                print("showAlerts: \(showAlerts)")
                if !(showAlertNoName  || showAlertNoName){
                    print("4")
                    activeAlert = areAllChangesSaved(recipes)
                    if activeAlert != ActiveAlert.showAlertRecipeNotSaved{
                        print("5")
                        clearDisk()
                        recipeSaved = false
                        showAlerts = false
                        savedValue.recipeSaved = true
                    }
                }
            }
            
            print(activeAlert)
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