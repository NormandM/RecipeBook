//
//  PhotoView.swift
//  RecipeForm
//
//  Created by Normand Martin on 2020-07-29.
//

import SwiftUI
import UIKit

@available(iOS 14.0, *)
struct PhotoView: View {
    @State private var image: Image? = nil
    @State private var imageUI: UIImage?
    @State private var showCaptureImageView: Bool = false
    @State private var cameraChosen: Bool = false
    @State private var imageIsShowed: Bool = false
    var body: some View {
        ZStack{
                image?.resizable()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            if image == nil && !showCaptureImageView{
            Text("Use the Camera\n\n\nOr\n\n\nChoose an existing Photo")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(.title)
            }
            
        }
        .navigationBarTitle("Photo", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                
                    Button(action: {
//
                    let data = imageUI?.jpegData(compressionQuality: 1.0)
                    }, label: {
                        Text("Save")
                    })
                    .padding()
            }
            ToolbarItem(placement: .bottomBar){
                
                    Button(action: {
                        self.showCaptureImageView.toggle()
                        self.cameraChosen = false
                    }, label: {
                        Label("Select Photo", systemImage: "photo")
                    })
                    .padding()
            }
            ToolbarItem(placement: .bottomBar){
                    Button(action: {
                        self.showCaptureImageView.toggle()
                        self.cameraChosen = true
                    }, label: {
                        Label("Take Picture", systemImage: "camera.fill")
                            
                    })
                    .padding()
            }
        }
        if (showCaptureImageView) {
            CaptureImageView(isShown: $showCaptureImageView, image: $image, imageUI: $imageUI, cameraChosen: cameraChosen)
            
        }
    }
}

@available(iOS 14.0, *)
struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
