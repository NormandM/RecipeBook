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
    @Environment(\.colorScheme) var colorScheme
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
                        VStack {
                            Button(action: {
                                self.showCaptureImageView.toggle()
                                self.cameraChosen = true
                            }, label: {
                                HStack {
                                    Text("Use the Camera")
                                        .font(.title)
                                        .foregroundColor(.blue)
                                    
                                }
                            })
                                .padding()
                            Text("or")
                                .foregroundColor(colorScheme == .light ? .black : .black)
                            Button(action: {
                                self.showCaptureImageView.toggle()
                                self.cameraChosen = false
                                
                            }, label: {
                                HStack {
                                    Text("Choose an existing Photo")
                                        .font(.title)
                                        .foregroundColor(.blue)
                                }
                                
                                
                            })
                                .padding()
                        }
                        
                    }
                    if (showCaptureImageView) {
                        CaptureImageView(isShown: $showCaptureImageView, image: $image, imageUI: $imageUI, cameraChosen: cameraChosen)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            self.showCaptureImageView.toggle()
                            self.cameraChosen = true
                        }, label: {
                            HStack {
                                Text("Camera")
                                Image(systemName: "camera.fill")
                            }
                            .padding()
                            
                            
                        })
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Spacer()
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            self.showCaptureImageView.toggle()
                            self.cameraChosen = false
                        }, label: {
                            HStack {
                                Text("Photo")
                                Image(systemName: "photo")
                            }
                            .padding()
                            
                        })
                    }
                    
                }
                
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
            .navigationBarTitle(NSLocalizedStringFunc(key:"Photo"), displayMode: .inline)
            .navigationBarColor(UIColorReference.specialGreen)
            .navigationBarBackButtonHidden(true)
            .background(ColorReference.specialSand)
            .edgesIgnoringSafeArea([.leading, .trailing])
            .navigationBarItems(leading:
                                    Button(action: {
                                        data = imageUI?.jpeg(.lowest)
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
            
        }
    }
}

//@available(iOS 14.0, *)
//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView(data: .constant(nil))
//    }
//}
