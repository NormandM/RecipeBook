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
    @Environment(\.presentationMode) var presentationMode
    @Binding var data: Data?
    @State private var imageUI: UIImage?
    @State private var showCaptureImageView: Bool = false
    @State private var cameraChosen: Bool = false
    @State private var imageIsShowed: Bool = false
    var existingdata: Data
    var body: some View {
        GeometryReader{ geo in
        VStack {
            Spacer()
            ZStack{
                ColorReference.specialSand
                    .edgesIgnoringSafeArea(.all)
                image?.resizable()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                if image == nil && !showCaptureImageView{
                    Text(NSLocalizedStringFunc(key:"Use the Camera\n\n\nOr\n\n\nChoose an existing Photo"))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .font(.title)
                }
                if (showCaptureImageView) {

                        CaptureImageView(isShown: $showCaptureImageView, image: $image, imageUI: $imageUI, cameraChosen: cameraChosen)
                }
            }
            HStack {
                    Button(action: {
                        self.showCaptureImageView.toggle()
                        self.cameraChosen = false
                    }, label: {
                        Label(title: {
                            Text(NSLocalizedStringFunc(key:"Select Photo"))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        , icon: {Image(systemName: "photo")
                            .foregroundColor(.white)
                            .font(.headline)
                        })
                            
                            
                    })
                    .padding()

                    Button(action: {
                        self.showCaptureImageView.toggle()
                        self.cameraChosen = true
                    }, label: {
                        Label(title: {
                            Text(NSLocalizedStringFunc(key:"Take Picture"))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        , icon: {Image(systemName: "camera.fill")
                            .foregroundColor(.white)
                            .font(.headline)
                        })

                    })
                    .padding()
            }
            .frame(width: geo.size.width, height: geo.size.height * 0.1)
            .background(ColorReference.specialGray)
            .edgesIgnoringSafeArea(.all)
            
        }
        .onAppear{
            if existingdata != Data() {
                showCaptureImageView = false
                cameraChosen = false
                data = existingdata
                guard let uiImage = UIImage(data: existingdata as Data) else { return }
                image = Image(uiImage: uiImage)
                imageUI = uiImage
            }
        }
        .navigationBarTitle("Photo", displayMode: .inline)
        .navigationBarColor(UIColorReference.specialGreen)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
                                    data = imageUI?.jpegData(compressionQuality: 1.0)
                                    if data != Data() {
                                        print("There is data")
                                    }
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text(NSLocalizedStringFunc(key:"Back"))
                                    }
                                })
        
//        .navigationBarItems(trailing:
//            Button("Save") {
//                if imageUI == nil {
//                    print("No imageUI")
//                }
//                data = imageUI?.jpegData(compressionQuality: 1.0)
//                if data == nil {
//                    print("No data")
//                }
//            }
//            .padding()
//        )

    }
    }
}

//@available(iOS 14.0, *)
//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView(data: .constant(nil))
//    }
//}
