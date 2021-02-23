//
//  iPhonePresent.swift
//  RecipeBook
//
//  Created by Normand Martin on 2021-02-23.
//

import UIKit
func isIPhonePresent() -> Bool {
    if UIDevice.current.userInterfaceIdiom == .phone {
        return true
    }else{
        return false
    }
}

