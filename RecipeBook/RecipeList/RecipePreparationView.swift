//
//  NutritionInformationView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-09-07.
//

import SwiftUI
import PDFKit
struct RecipePreparationView: View {
    @Environment(\.managedObjectContext) var moc
    var fetchRequest: FetchRequest<Recipe>
    var title: String
    var savedPdfView: SavedPdfViewUI
    @State private var preparationPdfPresent = Data()
    @State private var preparationText = ""
    @State private var isPDFPresent = true
    init(filter: String) {
        self.fetchRequest = FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
        self.title = filter
        self.savedPdfView = SavedPdfViewUI(filter: filter, nameOfScan: "Preparation.pdf")
    }
    var body: some View {
        GeometryReader { geo in
            VStack{
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.leading)
                    .padding(.trailing)
                if isPDFPresent {
                    savedPdfView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .border(Color.black, width: 1)
                        .padding()
                }
                if preparationText != "" {
                ScrollView {
                    Text(preparationText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                }
                .border(Color.black, width: 1)
                .padding()
                }
                
            }
            .onAppear{
                for item in fetchRequest.wrappedValue {
                    preparationText = item.wrappedPreparation
                    preparationPdfPresent = item.wrappedPdfPreparation
                }
                if preparationPdfPresent == Data() {isPDFPresent = false}
            }
        }
        .navigationBarTitle(NSLocalizedStringFunc(key:"Preparation"), displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .background(ColorReference.specialSand)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RecipePreparationView_Previews: PreviewProvider {
    static var previews: some View {
        RecipePreparationView(filter: "")
    }
}
