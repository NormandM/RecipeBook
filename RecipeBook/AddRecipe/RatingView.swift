//
//  RatingView.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-13.
//

import SwiftUI


struct RatingView: View {
    @Binding var rating: Int
    var isInteractif: Bool
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1, id: \.self){ number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        if isInteractif {
                            self.rating = number
                        }
                    }
            }
        }
    }
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        }else{
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4), isInteractif: false)
    }
}
