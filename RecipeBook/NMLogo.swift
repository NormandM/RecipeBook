//
//  NMLogo.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-13.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct NMLogo:  View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State private var xOffset: CGFloat = 300
    @Binding var appIsFirstOpen: Bool
    @Binding var firstOpenOpacity: Double
    var body: some View {
            GeometryReader { geo in
                ZStack {
                    
                    VStack{
                        Spacer()
                        Image(colorScheme == .light ? "Normand martin Logo" : "Normand martin LogoDarkMode")
                            .resizable()
                            .frame(width: geo.size.height/2.3, height: geo.size.height/2.3)
                        Text("Apps")
                            .font(.title)
                            .offset(x: self.xOffset)
                        Spacer()
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .onAppear{
                    withAnimation(Animation.linear(duration: 2.0).delay(1.0)) {
                        self.xOffset = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(Animation.linear(duration: 2.0)){
                            firstOpenOpacity = 0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        appIsFirstOpen = false
                    }
                    
                    
                }
            }
        }
}

//struct NMLogo_Previews: PreviewProvider {
//    static var previews: some View {
//        NMLogo()
//    }
//}
