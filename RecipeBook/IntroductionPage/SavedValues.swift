//
//  SavedValues.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-01-12.
//

import SwiftUI

class SavedValue: ObservableObject {
    @Published var recipeSaved: Bool = true
    @Published var noChangesMade: Bool = true
}
