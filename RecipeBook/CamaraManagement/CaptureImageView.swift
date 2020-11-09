//
//  CaptureImageView.swift
//  ReceipeDevelopment
//
//  Created by Normand Martin on 2020-07-27.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct CaptureImageView {
  
  /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var imageUI: UIImage?
    
    var cameraChosen: Bool
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image, image2: $imageUI)
  }
}
extension CaptureImageView: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    /// Default is images gallery. Un-comment the next line of code if you would like to test camera
    if cameraChosen {
        picker.sourceType = .camera
    }else{
        picker.sourceType = .photoLibrary
    }
    
    return picker
  }
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
      
    }
  }
