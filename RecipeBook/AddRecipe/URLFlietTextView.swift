//
//  URLFlietTextView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-11-05.
//

import SwiftUI

struct URLFlietTextView: View {
    @State var url: String = ""
        var body: some View {
            let binding = Binding<String>(get: {
                self.url
            }, set: {
                self.url = $0.lowercased()
            })

            return VStack {
                TextField(NSLocalizedStringFunc(key:"Enter URL"), text: binding)
            }

        }
}

struct URLFlietTextView_Previews: PreviewProvider {
    static var previews: some View {
        URLFlietTextView()
    }
}
