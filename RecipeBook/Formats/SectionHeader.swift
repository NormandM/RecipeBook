//
//  SectionHeader.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-12-17.
//

import SwiftUI
struct SectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: 35,alignment: .center)
            .background(ColorReference.specialGray)
            .foregroundColor(Color.white)
    }
}
