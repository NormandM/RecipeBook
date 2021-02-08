//
//  WaitingToShare.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-02-06.
//

import SwiftUI

struct WaitingToShare: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
                VStack {
                ProgressView("Preparing file to share")
                    .progressViewStyle(CircularProgressViewStyle())
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(20.0)
    }
}

struct WaitingToShare_Previews: PreviewProvider {
    static var previews: some View {
        WaitingToShare()
    }
}
