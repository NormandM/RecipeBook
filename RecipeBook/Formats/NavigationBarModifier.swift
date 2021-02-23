//
//  NavigationBarModifier.swift
//  RecipeBook
//
//  Created by Normand Martin on 2020-08-27.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.largeTitleTextAttributes = [
            .font : UIFont(name:"Papyrus", size: 40)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        // this only applies to small titles
        if isIPhonePresent(){

        }else{
            coloredAppearance.titleTextAttributes = [
                .font : UIFont(name:"Papyrus", size: 40)!,
                NSAttributedString.Key.foregroundColor : UIColor.white,]
            
        }

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().tintColor = .systemBlue
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}

//struct NavigationBarModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationBarModifier()
//    }
//}
