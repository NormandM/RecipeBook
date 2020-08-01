//
//  Extensions.swift
//  RecipeForm
//
//  Created by Normand Martin on 2020-07-29.
//

import SwiftUI
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
