//
//  KeyBoardHandler.swift
//  ReceipeDevelopment
//
//  Created by Normand Martin on 2020-07-26.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI
import Combine

final class KeyboardHandler: ObservableObject {
    @Published private(set) var keyboardHeight: CGFloat = 0
    
    private var cancelable: AnyCancellable?
    
    private let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification).compactMap{($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
    
    private let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).map{ _ in CGFloat.zero}
    
    init() {
        cancelable = Publishers.Merge(keyboardWillShow, keyboardWillHide).subscribe(on: DispatchQueue.main).assign(to: \.self.keyboardHeight, on: self)
    }
        
}
