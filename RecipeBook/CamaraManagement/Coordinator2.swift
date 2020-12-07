//
//  Coordinator2.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-11-16.
//

import SwiftUI
class Coordinator2: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: Image?
    @Binding var imageUI: UIImage?
    
    init(isShown: Binding<Bool>, image: Binding<Image?>, image2: Binding<UIImage?>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
        _imageUI = image2
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
       imageUI = unwrapImage
        imageInCoordinator = Image(uiImage: unwrapImage)
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
